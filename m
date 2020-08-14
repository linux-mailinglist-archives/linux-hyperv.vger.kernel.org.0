Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95F2449D0
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHNMjH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 08:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgHNMjH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 08:39:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B26520866;
        Fri, 14 Aug 2020 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408746;
        bh=GMHi1FpPrR62ulxDK6MxZ6BFhwvKlixc4HoFmHzpW3k=;
        h=From:To:Cc:Subject:Date:From;
        b=lKf44wUf2Kc3v1KN9FqczPLbiNSEB3nE1ZqTbD+tfrxWnlmj+xpAZ8cSyY7SZoVM4
         TAR8k//u7btxlzTAFfzmg6VtHFmHVA2UXlQqF9s677CPaz6UzyCwJYvc1NLgZ2JAk1
         HpCTi2zCWQIRmZFDJ1c19CfkmFBZkopM0+xjDTe4=
From:   Sasha Levin <sashal@kernel.org>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     gregkh@linuxfoundation.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 0/4] drivers: hv: Microsoft Virtual GPU Driver
Date:   Fri, 14 Aug 2020 08:38:52 -0400
Message-Id: <20200814123856.3880009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is a follow-up on the RFC sent a few months back[1].

Changes since the RFC:

 - Move to drivers/hv/
 - Address comments from Greg KH
   - Misc device initialization
   - Remove typedefs/variable defines
   - Use the kernel's ioctl declarations
 - Clean up random code bugs.


[1] https://lore.kernel.org/lkml/20200519163234.226513-1-sashal@kernel.org/


Sasha Levin (4):
  drivers: hv: dxgkrnl: core code
  drivers: hv: dxgkrnl: hook up dxgkrnl
  drivers: hv: vmbus: hook up dxgkrnl
  drivers: hv: dxgkrnl: create a MAINTAINERS entry

 MAINTAINERS                     |    7 +
 drivers/hv/Kconfig              |    2 +
 drivers/hv/Makefile             |    1 +
 drivers/hv/dxgkrnl/Kconfig      |   10 +
 drivers/hv/dxgkrnl/Makefile     |   12 +
 drivers/hv/dxgkrnl/d3dkmthk.h   | 1636 ++++++++++
 drivers/hv/dxgkrnl/dxgadapter.c | 1406 ++++++++
 drivers/hv/dxgkrnl/dxgkrnl.h    |  927 ++++++
 drivers/hv/dxgkrnl/dxgmodule.c  |  656 ++++
 drivers/hv/dxgkrnl/dxgprocess.c |  357 ++
 drivers/hv/dxgkrnl/dxgvmbus.c   | 3084 ++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  873 +++++
 drivers/hv/dxgkrnl/hmgr.c       |  604 ++++
 drivers/hv/dxgkrnl/hmgr.h       |  112 +
 drivers/hv/dxgkrnl/ioctl.c      | 5413 +++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/misc.c       |  279 ++
 drivers/hv/dxgkrnl/misc.h       |  309 ++
 include/linux/hyperv.h          |   16 +
 18 files changed, 15704 insertions(+)
 create mode 100644 drivers/hv/dxgkrnl/Kconfig
 create mode 100644 drivers/hv/dxgkrnl/Makefile
 create mode 100644 drivers/hv/dxgkrnl/d3dkmthk.h
 create mode 100644 drivers/hv/dxgkrnl/dxgadapter.c
 create mode 100644 drivers/hv/dxgkrnl/dxgkrnl.h
 create mode 100644 drivers/hv/dxgkrnl/dxgmodule.c
 create mode 100644 drivers/hv/dxgkrnl/dxgprocess.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.c
 create mode 100644 drivers/hv/dxgkrnl/dxgvmbus.h
 create mode 100644 drivers/hv/dxgkrnl/hmgr.c
 create mode 100644 drivers/hv/dxgkrnl/hmgr.h
 create mode 100644 drivers/hv/dxgkrnl/ioctl.c
 create mode 100644 drivers/hv/dxgkrnl/misc.c
 create mode 100644 drivers/hv/dxgkrnl/misc.h

-- 
2.25.1

