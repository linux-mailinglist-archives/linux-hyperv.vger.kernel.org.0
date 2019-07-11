Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9298D65F75
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Jul 2019 20:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfGKScV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 Jul 2019 14:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbfGKScV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 Jul 2019 14:32:21 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCCFC208E4;
        Thu, 11 Jul 2019 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562869940;
        bh=ZGJHGxvWjkmLrsWM1dhqmklzcHtzVUWFgm5DE5lo7Vk=;
        h=Date:From:To:Cc:Subject:From;
        b=b6ciN7n2S8VrPN4nnZomJ4JBTxlYIC22zJ1StXo74zKXooJfhdnfniXtRh1lAIK4Z
         crnfOC4kwGnwtVP8oaPtKGBCXDWwT1rxywsgwZ8Cv4ftplvtrIpakvL18Ejq0eoFgI
         KEs7evYWfVKEd/96mEGrdxMkJFAG4lVWQ+7Dv2Z8=
Date:   Thu, 11 Jul 2019 14:32:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     gregkh@linuxfoundation.org, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org, linux-kernel@microsoft.com
Subject: [GIT PULL] hyper-v patches for 5.3
Message-ID: <20190711183218.GA10104@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

Please pull the signed tag below for two Hyper-V commits for 5.3.

You will see a conflict in arch/x86/include/asm/mshyperv.h due to
few Hyper-V related patches that went through tglx's tree, please
resolve that by keeping the header inclusion at the end but removing the
TSC related code. For reference, this is a correct resolution in
linux-next:
https://lore.kernel.org/lkml/20190709195358.25af244b@canb.auug.org.au/ .

Yes, this conflict is new-ish, but mostly because we split a series of
patches between this tree and tglx's. The patch in question is the same
as it was when I've accepted it back in May, and is well tested at this
point.

The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:

  Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed

for you to fetch changes up to 765e33f5211ab620c117ff1ee0c4f38c10f7a973:

  Drivers: hv: vmbus: Break out ISA independent parts of mshyperv.h (2019-07-08 19:06:27 -0400)

----------------------------------------------------------------
- Add a module description to the Hyper-V vmbus module.
- Rework some vmbus code to separate architecture specifics out to
arch/x86/. This is part of the work of adding arm64 support to Hyper-V.

----------------------------------------------------------------
Joseph Salisbury (1):
      drivers: hv: Add a module description line to the hv_vmbus driver

Michael Kelley (1):
      Drivers: hv: vmbus: Break out ISA independent parts of mshyperv.h

 MAINTAINERS                     |   1 +
 arch/x86/include/asm/mshyperv.h | 148 ++--------------------------------------------------
 drivers/hv/vmbus_drv.c          |   1 +
 include/asm-generic/mshyperv.h  | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+), 143 deletions(-)
 create mode 100644 include/asm-generic/mshyperv.h
