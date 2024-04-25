require("lualibs.lua")

function getJsonFromFile(file)
  local fileHandle = io.open(file)
  local jsonString = fileHandle:read('*a')
  fileHandle:close()  -- Use ':' instead of '.'
  local jsonData = utilities.json.tolua(jsonString)
  return jsonData
end

function printEduItems(file)
  local json = getJsonFromFile(file)
  for key, value in pairs(json) do
    tex.print("\\resumeEduEntry")
    tex.print("{" .. value["school"] .. "}")
    tex.print("{" .. value["school_location"] .. "}")
    tex.print("{" .. value["degree"] .. "}")
    tex.print("{" .. value["time_period"] .. "}")
  end
end

function printExpItems(file)
  local json = getJsonFromFile(file)
  
  for _, value in ipairs(json) do
    tex.print("\\begin{small}")  -- Use \begin{footnotesize} if you want a smaller size
    tex.print("\\resumeSubHeadingListStart")
    tex.print("\\resumeExpEntry")
    tex.print("{" .. value["company"] .. "}")
    tex.print("{" .. value["company_location"] .. "}")
    tex.print("{" .. value["role"] .. "}")
    tex.print("{" .. value["stack"] .. "}")
    tex.print("{" .. value["time_duration"] .. "}")

    tex.print("\\resumeItemListStart")
    for _, detail in ipairs(value["details"]) do
      tex.print("\\item{" .. detail["title"] .. " \\hfill \\textit{" .. detail["languages"] .. "}}")

      -- Check if "scale" field exists before concatenating
      if detail["scale"] then
        tex.print("\\newline \\textbf{ Scale:- }  " .. detail["scale"] .. " \\hfill")
      end
      -- Print descriptions with sub-bullets
      tex.print("\\begin{itemize}")
      for _, description in ipairs(detail["descriptions"]) do
        tex.print("\\item " .. description)
      end
      tex.print("\\end{itemize}")
    end
    tex.print("\\resumeItemListEnd")
    tex.print("\\vspace{-1pt}")
    tex.print("\\resumeSubHeadingListEnd")
    tex.print("\\end{small}")  -- Use \end{footnotesize} if you want to revert to the original size
  end
end


function printProjItems(file)
  local json = getJsonFromFile(file)


  for _, value in ipairs(json) do
    tex.print("\\begin{small}")  -- Use \begin{footnotesize} if you want a smaller size
    tex.print("\\resumeSubHeadingListStart")
    tex.print("\\resumeProjectHeading")
    tex.print("{" .. value["title"] .. " $|$ \\emph{  \\textbf {Stack:- } " .. value["languages"] .. " }}")
    tex.print("{" .. value["time_period"] .. "}")

    tex.print("\\begin{itemize}")
    for _, description in ipairs(value["descriptions"]) do
      tex.print("\\item " .. description)
      tex.print("\\vspace{-5pt}")
    end
    tex.print("\\end{itemize}")

    tex.print("\\vspace{-3pt}")  -- Adjust the space as needed
    tex.print("\\resumeSubHeadingListEnd")
    tex.print("\\end{small}")  -- Use \end{footnotesize} if you want to revert to the original size
  end  
end





function printHeading(file)
  for _, value in ipairs(getJsonFromFile(file)) do
    tex.print("\\begin{center}")

    tex.print("\\textbf{\\Huge \\scshape " .. value["name"] .. "}")
    tex.print("\\href{" .. value["website"] .. "/}{\\textbf{\\small\\faLink}} \\\\")
    tex.print( value["phone"] .." $|$ \\href{mailto:" .. value["email"] .. "}{\\faEnvelope} $|$ \\href{" .. value["linkedin"] .. "}{\\faLinkedin} $|$ \\href{" .. value["github"] .. "}{\\faGithub}")
    
    tex.print("\\end{center}")
    tex.print("\\vspace{-25pt}")
  end
end




function printSkills(file)
  local json = getJsonFromFile(file)
  local skills = json[1]["skills"]
  
  for _, skill in ipairs(skills) do
    tex.print("\\textbf{" .. skill["title"] .. "} | \\emph{" .. skill["details"] .. "}\\\\")
  end
end






