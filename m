Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6108108857
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2019 06:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfKYFeK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 00:34:10 -0500
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:7331
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfKYFeK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 00:34:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqB4rVnxIBoVFpyN2YC6YlB8mrtr00CR1H5ZNBsNZpjacSJTzZ12kI0+nKVqKskKaEG8GiB16XMLaHYFBU/wnGZtd+/QUrb8Ko135ck/URygazyHvsn7Z9MnrZpkXsu1t6RuqzBXBgnzwADrupSzFsQfB6VBx7RJ6yui/hxkpB33XeMHm1OK8/S5ghyxuNELm2/rP9/D84foUQGdECeEr7b1tHHR26+/4fvqRZVR2iVB3ZLyqp3++Jd43lp7Pt6QGWihvLlFQzLA+UvFdUGPZIRZSIsqUcdeVLas7T8hJqpDmTwKhZrCsBrES+ZvKA6kcRh2Rxv4+wNXTTQtIPZPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25ooNnqkx1NicJb25qyZmTsHWJWFs9SQghLLGxs3G+g=;
 b=eTjDTDRs5HovMs7YkH98J9DurfoPVDu5E6rM/Rc5Y5D6ibS/RR+E/owzN5DVML7Z0ULdSEmMfnOvT3YMYdTWCv0BzuYhAJDChveOGetUGPVOJU3FxJSZEpu65Ro+HA9qaha357wAgIXDVxc1Tzlni69ucV1rKtGnfZ01OIDHvFMi7w9nf+Jyocv0C3jArTb+J2YOAbpmGVB3D1nDqyNn3qLdV2CWsz1OQzAicaepkSFXMeV+SNq69B0VIOzq42UyGFbFJSW8cGG+mdn+LzN3u/hxZdx0ANEfhpikIxEYzSNs0xhbRe+YSvxK6L0IoyyCybD0YYkLDOiJbopOiw4B9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25ooNnqkx1NicJb25qyZmTsHWJWFs9SQghLLGxs3G+g=;
 b=dGw9WXsZ2dgDPi6O1paZT2oMLrbjX7d/X4cnhBjuNY0CoTDqfzWMejyZhAgyR474dJyFUd9+pHK7YEzPT+y3pM/6A76kyuLP5do6YVO2hIeWQOjrbcKWbGWnWTpqSkVEUceVg4IU0w5meleq0VdCIkd9/35pUyEIiyTj6wsMsL8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BYAPR21MB1141.namprd21.prod.outlook.com (20.179.57.138) by
 BYAPR21MB1189.namprd21.prod.outlook.com (20.179.57.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.1; Mon, 25 Nov 2019 05:34:07 +0000
Received: from BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89]) by BYAPR21MB1141.namprd21.prod.outlook.com
 ([fe80::5d0f:2e49:3464:7c89%3]) with mapi id 15.20.2495.014; Mon, 25 Nov 2019
 05:34:07 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 0/4] Enhance pci-hyperv to support hibernation, and 2 misc fixes
Date:   Sun, 24 Nov 2019 21:33:50 -0800
Message-Id: <1574660034-98780-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:300:13d::21) To BYAPR21MB1141.namprd21.prod.outlook.com
 (2603:10b6:a03:108::10)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR20CA0011.namprd20.prod.outlook.com (2603:10b6:300:13d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 25 Nov 2019 05:34:07 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfcbd2aa-652c-43c1-2d87-08d771691780
X-MS-TrafficTypeDiagnostic: BYAPR21MB1189:|BYAPR21MB1189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR21MB1189BB83F41F0A3BC2C39FE5BF4A0@BYAPR21MB1189.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0232B30BBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(366004)(136003)(346002)(189003)(199004)(6116002)(3846002)(4326008)(107886003)(6486002)(6436002)(10090500001)(3450700001)(2906002)(50466002)(48376002)(25786009)(6512007)(26005)(6506007)(386003)(51416003)(52116002)(4744005)(66946007)(66556008)(66476007)(6636002)(4720700003)(86362001)(7736002)(186003)(2616005)(956004)(16526019)(36756003)(66066001)(8936002)(8676002)(5660300002)(81156014)(47776003)(81166006)(1511001)(50226002)(10290500003)(478600001)(316002)(305945005)(6666004)(16586007)(43066004)(22452003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1189;H:BYAPR21MB1141.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VIcsMpgyeb3lK5lwAncc67o1IQTxJUMBO5XTUHHnN2k8Ur5/j1pFHa99ztokvO0DZi4fDUMv0/9LGSJM4/+AT169SBe3ohdLbX75uhNYyiXgOxaZDEcxMSwXzR3xh12lnkMmg5AngHkRc5zD7pHCXHyWdENbOEAT9R09SvjmowLKUo8Q+HI7cyiyVDF7FeRI4paft/+8WXb114C1HUjcR6sKG9kpgEHPkg0IyE812NUpKFPWEp0Jp31/8emna15pwDMuInsAbmi3WdTZJTRdR6wkNUqcEXUdZssmoSj9TWlmXTfKADmvJ7mvU9CP/gkaV9ZL4ZF744zCcM8nmU+iO7xBdl2EvCe/QpOqwV3ytC3/8+0j+8ZtRtjxLX7DQg5YYqcvyZEix7Mtz6p2mAVaCu+dGXUDUk24h5BPDj4gKiFG50WjpxBIkdqcl5/0leJ
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfcbd2aa-652c-43c1-2d87-08d771691780
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 05:34:07.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEEHcw1dLdPlLZHiVq8QLDgg9T7D6HSllSswMOTmubynfmMRglYoHfxTGNBEk+ipae7q8/0U84zX2k5osvggdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1189
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I suggest the patchset goes through the pci.git tree.

Patch #1: no functional change.
Patch #2 enhances the pci-hyperv driver to support hibernation.
Patch #3 is unrelated to hibernation.
Patch #4 is unrelated to hibernation.

Changes in v3:
Patch #1: Added Michael Kelley's Signed-off-by.
Patch #2: Used a better commit log message from Michael Kelley.
Patch #3: Added Michael Kelley's Signed-off-by.
Patch #4: Used kzalloc() rather than get_zeroed_page()/kmemleak_alloc()/
          kmemleak_free(), and added the necessary comments.

Michael, can you please review #2 and #4 again?

Dexuan Cui (4):
  PCI: hv: Reorganize the code in preparation of hibernation
  PCI: hv: Add the support of hibernation
  PCI: hv: Change pci_protocol_version to per-hbus
  PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer

 drivers/pci/controller/pci-hyperv.c | 208 ++++++++++++++++++++++++----
 1 file changed, 179 insertions(+), 29 deletions(-)

-- 
2.19.1

