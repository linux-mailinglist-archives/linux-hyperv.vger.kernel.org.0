Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4441B149956
	for <lists+linux-hyperv@lfdr.de>; Sun, 26 Jan 2020 06:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgAZFu1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Jan 2020 00:50:27 -0500
Received: from mail-mw2nam10on2112.outbound.protection.outlook.com ([40.107.94.112]:58464
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgAZFu1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Jan 2020 00:50:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPecI4VEaGASMZBVJBc0S+04yMkbqIq+MrThIRpl5shjczmjwGBDLS6fTZxaMRKhXzqwmFwPND6rnLykPpF7p3MVbLrEuF+gM+3K/r3m1t8DKdZkBSmK6EAfdBkjVb4/kdamba3JQl/cMk2g+3phDO1hX2Ag4pZV1j0S+QBuJUUl/JURmXBZbFHc6GmeHmTs9smZ3oiu6YRx6xBUklVrml0Nu9HpiGQzQkvxzlDYNrIZzdHlu/pkfG1UaLFRj2gEUGUTn0qEOJl8ny6yEOnECh3Kr7t88jcAeLtUqX3vvEQfYKtVbumlbcFHvEmkEYSyFfRkNLo98+9uEubz5tw5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjxZ6VcrB+GglF1RApyFzuzI9n63uzm+0SRIZEhqlG0=;
 b=hQZG36wZCUWWtWYHMwyCsKJyHXxnkF40GtUMcvbYYyE+Eyim4VUnHLqIABO2UDq2WkCOy2SDRkF7pqmB0NlQzC9MlNhELE0n7JYeYbafwoQRNPoJfBXng3fBPLy4csjEjuW3zmmQHIgCeV2ohJsyOWbOajtoxx1CShsY/PLp8lNmlBIvvTdXom4BdOdmOWtmWXJDnWGWH/kj9HX3Cfc/21fFyTy36GKcuY+TGkccfOPyPfgVfnp38Fki1IOvukvHnz1dg26C15dK9LFWxeGgVG1DBJ28a5MreiijBpCK5o4eeNPBW7bJmX9b1w1cvu4UenNS5rjkaz/WFgKB1Ufpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjxZ6VcrB+GglF1RApyFzuzI9n63uzm+0SRIZEhqlG0=;
 b=Wcl4VUaeD0QXFd62U35CVR3QStP1Uw+XYQeeWkp6UyM8SeqA22kOoHCCCikvMjGhuJ5DqTWcxcIe+ITzUJzuf2msNIGxdqtZOT9FzSSWLQVf84ffInK3d90rmdMU69VYxZLgmVqjTFwmQZDY1eJX5LhbEZObv5HqylfEAGLUx7Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1139.namprd21.prod.outlook.com (20.179.72.138) by
 BN8PR21MB1203.namprd21.prod.outlook.com (20.179.73.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.6; Sun, 26 Jan 2020 05:50:23 +0000
Received: from BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e]) by BN8PR21MB1139.namprd21.prod.outlook.com
 ([fe80::b4cb:911c:ec4a:950e%7]) with mapi id 15.20.2686.019; Sun, 26 Jan 2020
 05:50:23 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v4 0/4] hv_utils: Add the support of hibernation
Date:   Sat, 25 Jan 2020 21:49:40 -0800
Message-Id: <1580017784-103557-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0028.namprd14.prod.outlook.com
 (2603:10b6:300:12b::14) To BN8PR21MB1139.namprd21.prod.outlook.com
 (2603:10b6:408:72::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR14CA0028.namprd14.prod.outlook.com (2603:10b6:300:12b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23 via Frontend Transport; Sun, 26 Jan 2020 05:50:21 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4e08d58-bbee-45a2-8ecc-08d7a223a258
X-MS-TrafficTypeDiagnostic: BN8PR21MB1203:|BN8PR21MB1203:|BN8PR21MB1203:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB120319C5CD1068D437A73FE2BF080@BN8PR21MB1203.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02945962BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(199004)(189003)(316002)(2906002)(66556008)(6512007)(66946007)(66476007)(86362001)(107886003)(3450700001)(6486002)(36756003)(4744005)(8936002)(26005)(5660300002)(4326008)(2616005)(956004)(478600001)(186003)(52116002)(6506007)(6666004)(16526019)(81166006)(81156014)(8676002)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1203;H:BN8PR21MB1139.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U+UOYN9dC6B6ltIlBfpU0M/U7M1VCp7a19CsJ2eFqYo4/OiTWxkkHwZot54jMv6hgA78Yk4etznTCm+LfdkRs+DjdnZ4wsta/LBRZvqjflVoqAJn+ls+K/G9AUejPNvUoMwP4Ms4bHYDeeIgrCTdHTg1seeFRNwdRheS7ux9HKZPMwdYEu1Ic+4qDS0m2toTN4z9WMUjCjHIPnlErh6PwXZnj4SgmVB4voKtpc19I6ou9o3h7OFeOUR82Rlk30+YhbKNKbcFRpocyiTJlMnBk+8zEGidllrN8JI5OloyW6SXpwPkSZ+TU8RFobdJOS3BtsnaWFCYjFTMLN5Q4gYvOofS3CCtNE95+1/RQJ+P1NFObJVQ48GQQS6cxAJP8xxRI7N+mE3ILFZxWCovXLEZcLxPBNu/MWRfv5ySvYx4lAm+ydlL0D4Ia0fYDkZaMl5t
X-MS-Exchange-AntiSpam-MessageData: uN4Vn/VQNNUjUHMj9qedRlOhVqCwcoYt8Ew/KxV4NtK/ZyupGRl2kfRoOIEoSzzYBA/fCWiWLeUr6D2mKfGfS5XguIkAsRY1a0buEKATz7O6kiQvISkkkt1O60CNTw/gWWkRKXar8hTdoAiehwIjeQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e08d58-bbee-45a2-8ecc-08d7a223a258
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2020 05:50:23.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXp2feoE+uwSMAJbyawaLx6NbUtMgmANJ3j6HunfZENrTUAjWxf9cPIF/99C8RUx/FHKrPx89VnRgl3DHBmXog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1203
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,

I addressed the new comments from Michael, and documented the changes
after the "---" line in every patch's changelog.

Please review.

Thanks!

Dexuan Cui (4):
  Tools: hv: Reopen the devices if read() or write() returns errors
  hv_utils: Support host-initiated restart request
  hv_utils: Support host-initiated hibernation request
  hv_utils: Add the support of hibernation

 drivers/hv/hv_fcopy.c      |  54 +++++++++++++-
 drivers/hv/hv_kvp.c        |  43 ++++++++++-
 drivers/hv/hv_snapshot.c   |  55 +++++++++++++-
 drivers/hv/hv_util.c       | 148 ++++++++++++++++++++++++++++++++++---
 drivers/hv/hyperv_vmbus.h  |   6 ++
 include/linux/hyperv.h     |   2 +
 tools/hv/hv_fcopy_daemon.c |  37 ++++++++--
 tools/hv/hv_kvp_daemon.c   |  36 +++++----
 tools/hv/hv_vss_daemon.c   |  49 +++++++++---
 9 files changed, 385 insertions(+), 45 deletions(-)

-- 
2.19.1

