package backend.entity.custom;

import backend.entity.User;


public class UserVo extends User {
    String roleIdsStr;

    @Override
    public String getRoleIdsStr() {
        return roleIdsStr;
    }

    @Override
    public void setRoleIdsStr(String roleIdsStr) {
        this.roleIdsStr = roleIdsStr;
    }
}
