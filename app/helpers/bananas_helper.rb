module BananasHelper

  def gridhelper sizex, sizey
    s = ""
    s << "<table ><tbody>"
    @bananas.in_groups_of(sizex) do |rows|
      s << "<tr>"
      rows.each do |b|
        s << "<td>"
        s << (imghelper b.ripeness)
        s << "</td>"
      end
      s << "</tr>"
    end
    s << "</tbody> </table>"
    s.html_safe
  end

end