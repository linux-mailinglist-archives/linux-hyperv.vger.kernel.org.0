Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D261743024
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jun 2023 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjF2WJx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 18:09:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:41646 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjF2WJp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 18:09:45 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id F17ED2083969; Thu, 29 Jun 2023 15:09:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F17ED2083969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1688076584;
        bh=bRJBnZIyqX5lWmieXAT5ZWBktdQw7iN0MiN86gS1bd0=;
        h=From:To:Cc:Subject:Date:From;
        b=qy2y55CfMDoH/brlN1bIt1o/wgwyjDECNCRlOQ6OL2ndQITH/NHG9QbFQxQ6FZfVy
         aDJIc+NoW/q2XUyTS3V/f+FFsDAc9lpZDmEDtcrTWPnEIsgSACCXAnv731fZzdy7nj
         wTIZWIM9XuPM5a1Yb2gNi1V2G4sZ1olDysSTUyr8=
From:   longli@linuxonhyperv.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Shachar Raindel <shacharr@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: [PATCH net v4 0/2] net: mana: Fix doorbell access for receive queues
Date:   Thu, 29 Jun 2023 15:09:29 -0700
Message-Id: <1688076571-24938-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

This patchset fixes the issues discovered during 200G physical link
tests. It fixes doorbell usage and WQE format for receive queues.

Long Li (2):
  net: mana: Batch ringing RX queue doorbell on receiving packets
  net: mana: Use the correct WQE count for ringing RQ doorbell

 drivers/net/ethernet/microsoft/mana/gdma_main.c |  5 ++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c   | 10 ++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.34.1

