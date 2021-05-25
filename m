Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959C2390CE3
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 May 2021 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhEYXUl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 May 2021 19:20:41 -0400
Received: from mail-dm3nam07on2130.outbound.protection.outlook.com ([40.107.95.130]:31713
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229898AbhEYXUk (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 May 2021 19:20:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWfobxOBCqs9xwUWD+r08PTptHY5jweYsnxJ5MuE1Z2+lpiWtf5Nmnu86OHzAR9W6NwUv+kfujY7iAneqmZ/Jtb1e0KLcE0RFl4iYnAv25AumuRE/tSct1XeAcrBqLYMUEaTp/HqDQVRQaWjogcq4omMbpx7V96p9m9qkN/Dc9kZsF5tG1f6gtTkr1qcgiuOGimpRpXTTO2YqBAyYV0NOqAMu9q4JoAu3iws6oRgq50onBNDa/QaaRRNH6OA4uF4luNm/rydF7L/U78qfKl8x/FhrYmiZEYi2wefgfEfugdzcaDtDHMaxuNcfiz+N0+tHLYc5/ro9/Uq//NcBBqVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svjoeYaBhHsXP0Li7OBgbi31w+7emAFmit6UsEZE7oY=;
 b=I7CSx1SquRW7XppRvTWIbhox05DNftN7xz+JI6CNaNkama30EjmocedPiXLk1fiHOBXR6GD5T3PQsTDeNVf+T447ZaNvX4IiYFI8WT/6C7T3T1cVVr09vjzxoN/2JWyBPT+DFtbO3p/4l43HTlNPnpuGycWBk+cTXLBxh6l62jxB2N4af6mnDMRxb1AL4qCgQX5LJ1v7Uib2SdKiL65Wz9asVy4/hWb9APDtwjYWlIC/Zy3yHj5eVnjcaEDalt6RFY5ZWGwjRSk0s7qCnusJgIUbphAD+Vs4+iWlPeJGT1kA9Rs89Qt4YQOgtFxNBmzKS1Z8XmI/Bj1gx1T6NoZN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svjoeYaBhHsXP0Li7OBgbi31w+7emAFmit6UsEZE7oY=;
 b=CMGzMTTAaYFNAhK75tVHiCv4EX+msfhOOr650Fc3b2hHeZnk/q72BJtqLymgrOGnMZSQLZjN+H0OKJ5cq4X6Sw+HcT/DTZft6MN03Gz930zkHpvgoc2JhsOT/PLioNwwmkjoDOIu70gKQUhi1/T52nrRD/22InLKS/e+zYYyAUA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1340.namprd21.prod.outlook.com (2603:10b6:5:175::19)
 by DM5PR2101MB1110.namprd21.prod.outlook.com (2603:10b6:4:a5::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.15; Tue, 25 May
 2021 23:19:08 +0000
Received: from DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::6410:fb1:42e6:a795]) by DM6PR21MB1340.namprd21.prod.outlook.com
 ([fe80::6410:fb1:42e6:a795%9]) with mapi id 15.20.4195.008; Tue, 25 May 2021
 23:19:03 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     haiyangz@microsoft.com, kys@microsoft.com, olaf@aepfle.de,
        vkuznets@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] pci-hyperv: Add check for hyperv_initialized in init_hv_pci_drv()
Date:   Tue, 25 May 2021 16:17:33 -0700
Message-Id: <1621984653-1210-1-git-send-email-haiyangz@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [13.77.154.182]
X-ClientProxiedBy: MW4PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:303:8c::12) To DM6PR21MB1340.namprd21.prod.outlook.com
 (2603:10b6:5:175::19)
MIME-Version: 1.0
Sender: LKML haiyangz <lkmlhyz@microsoft.com>
X-MS-Exchange-MessageSentRepresentingType: 2
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 23:19:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d556ac6d-c25b-4138-2f18-08d91fd37bec
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1110FF713D6DB9BC74F39621AC259@DM5PR2101MB1110.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FIXMLDEAaXD4Fj3B+RReAOBjMcwE+7jb1kl+qUqIWFsXR52VeC8+v4XXAc9+VyjMEN+ZHFppIT8mLhFk3WvX3yeEW0kOk9SbvNzkNr/zBt3jDxRaT9groSJPuHAeT7zapNgC8PRMkTUri6AVhAvWix71jYN+TSqpKoFg/SBfMwIXJT7kIOrFkV6GHu3mIkwx+tztT6cx35kLWeBIhS9iqieenIIh5Hfd2AVNZzPFl51IEZeHZQfMaqnLoc5sccImyXpRrLH1XkX3JBQAcja+HeZWTn9UHDgqvdPMWERkjU6sUa9mvGz5UFcIP9TDOVShtoJPFZ/jnqzi0mqnHFax3aEZ/MF0AvcN7OfTLtu29Xm3ORee4YynH9yjl95HG5TbQXhcHgpkmKYrPLcjv+DHfZO6k3lmy9TusLdW2ASyPIUcZ/QRtGqcozM335oim8vSQnDsj1Lls+fO+yZbDjV+rIB2EJm2pc6gOxjpKe0EwzICOncimx6zwQdTRso8yH2YScCMTj+sTw0d2falDaMBaCr2zaNN3kdfw3+Jb1ZuYh3pgCSI6OIcZLO+zAnEQeM7a61Vcr0FLGH1CnXGna/6NMJYRp5GOO8pQN7FNAnF3BmkwdSOvyZsoKt/MlkJs1gxzGNQJpp7C/blXVZiCLZIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1340.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(16526019)(36756003)(26005)(7846003)(6666004)(6512007)(2906002)(316002)(4744005)(6486002)(956004)(6506007)(186003)(2616005)(4326008)(38100700002)(5660300002)(66556008)(8676002)(66946007)(8936002)(10290500003)(82960400001)(82950400001)(83380400001)(66476007)(38350700002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sSkPGNzCk8Zb/dPIlk9uj2uB03yxVhvXKNObk5QCi2OQa+fq3hqOWQ75tILX?=
 =?us-ascii?Q?nt3infQnHTIW6cpXqdO1C5dsGcJBlw1rzRaHpiKb0qI4k6WPxYzhwoPwLLGk?=
 =?us-ascii?Q?yxJy2gtmsGXsbLOaKFzvUweR5MbQsNB6+gk8N/fB/ojqpMT0T86NhKD+kgqH?=
 =?us-ascii?Q?E7fqO65nZicX2X/MDVpRB2zg36Gq53kxsB7ylN3cgqCu+BJzmt9TTAbog61x?=
 =?us-ascii?Q?evbZEuoVYo1Au+iPXNgpxEXwPt/UL/mIN/ldjHl8uNankKy8Bn5Kss80SCS2?=
 =?us-ascii?Q?wzaBzfT21oDBB/djNzA9i3GqBBsUrQsNWgOZXMtwpa4evDSWZv+YuuqmAK0a?=
 =?us-ascii?Q?l6QkcquxKDJDaQkpN7cZbb8E3hhkoG5PFSoDdlMlCuCwrefTYnkSAJVZmU5E?=
 =?us-ascii?Q?DakG3LRx0d1F+6r5U1oaKQkTLA2y+Ud/jLsLI3AfG2jgyhSwMuuBHYSzEPc0?=
 =?us-ascii?Q?DeHMQdd/37ftgr9MuKJcuEdwYPjF/rXKSOPQpKkVWdGi1dZHI+qbc7aHSMVr?=
 =?us-ascii?Q?HruxwS19QfQhFoTftUF5hY9o/pvc0yMOKocf2IB6Zmaoozn7kU17yxLmbT4z?=
 =?us-ascii?Q?FayqJI3IeHxs632CILW/o3NZ69/XcO2RKJyPoV4OWMyFva7EwlBbxZ34zdcM?=
 =?us-ascii?Q?IR3tt23+oD/XnjL4InGrWspmZRnb1MVeMvu2dLC0veYnEd9+FxoBsLh67nPf?=
 =?us-ascii?Q?F6uAy5e6MH9u0i46UfSX+zhW378oojJbQ9yuSLcXT3nRJ5OvzfHMt1KjA8+n?=
 =?us-ascii?Q?xSRNAMqMOyVbSXm6nxJ55tNiGlSHTRwNR3GoJGUT2tBhBWCeLTIDD7JwbPNS?=
 =?us-ascii?Q?VuZJzQcadL7gl1c3V0+vgWULMtZosrao5TFfe1WvpjdLjphHwxg/mA9HWJOr?=
 =?us-ascii?Q?w5bdWJ/fY8KydznhzZPEorqVAJveC9d7MZsAq9ks/lwyo98r797w38jFC5j3?=
 =?us-ascii?Q?dVl/50TDWQ7q/JysAaLgqjbm4ez469DAM98bbb1s?=
X-MS-Exchange-AntiSpam-MessageData-1: 4dColPZ6ExoNReQz/AIWBff79JOxMODl0HuYnQAI3FA0lR2d7DZH+wzp660kxi9HADyg/WDczIKbOyb6WnJlR1n/iSP72i5+aQGlhSj/MsC+jDifwzVpzedKgm+SVCiJGS0naGJFO9m9Y4jgO12fa0wQRd6d3n8D9kMVH5ayelupeLb1q5Guj90iixNJ92W0vKWT7+5i80w830q/ScvIJU4QgG9m0P4Q7gkeupDBdtOcP8YQO9TfjyOrGPDDFjnY9WvIsbtnZzbx2bD15rPfOI15IMfQY58Qdrb26OTj8v3UFlrf3hiPSZMeEv9zbAyOxXjDCD1SRaxLf2CM8SfqrZRu
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d556ac6d-c25b-4138-2f18-08d91fd37bec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1340.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 23:19:03.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgOVIWsB18oXdAFR0QcXIk9oXaBXudF5+s1HhV7yauwfP9nepq9Lu1L3efDyxSf/k0FjD1E5HbbSgSjxWkS2gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add check for hv_is_hyperv_initialized() at the top of init_hv_pci_drv(),
so if the pci-hyperv driver is force-loaded on non Hyper-V platforms, the
init_hv_pci_drv() will exit immediately, without any side effects, like
assignments to hvpci_block_ops, etc.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reported-and-tested-by: Mohammad Alqayeem <mohammad.alqyeem@nutanix.com>
---
 drivers/pci/controller/pci-hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 6511648271b2..bebe3eeebc4e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3476,6 +3476,9 @@ static void __exit exit_hv_pci_drv(void)
 
 static int __init init_hv_pci_drv(void)
 {
+	if (!hv_is_hyperv_initialized())
+		return -ENODEV;
+
 	/* Set the invalid domain number's bit, so it will not be used */
 	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
 
-- 
2.25.1

