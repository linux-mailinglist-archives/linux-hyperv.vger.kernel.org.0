Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3B272A4CC
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Jun 2023 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjFIUj3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Jun 2023 16:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFIUj2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Jun 2023 16:39:28 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364052D7C;
        Fri,  9 Jun 2023 13:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAs20PerSiuKH/XLdXSJa3GUPV9dP0zO6OPbrLbcR2zDV1RX4JbAkogCeIQpPKy5l8PhbzexhCzl5Z0VieRxPVANW+Ezn8iYADiGkEagDJARSs1eI4CAjhsAOQB9qMPFbigG/EV7vgPNplKuJFsw1d20WeFnGF6PHXPJuEcYBv91znJqRS1H5MapsC5twd1+NC7w8LLj1+F7IoytS5rEWl4OqNmPdgNru521DYh2/OXRsASrWg22IfzrNLnM+UXNf/f/vqSAuvujSC0XMeDV8fe+cMTwvvJpbu8+J848Upjt4Ov8n2W2px160aE2+fKptg5P+Eolp1JMsG5+CdDwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jPMz2tVI/FMbDhYJZsqHAhq/VD4UANM+LOK/VxDiFc=;
 b=lC2KWW6D49lpwHsoYwVQA2IG2vst+jpkm8L9VIryT766VYoQpfM7+xaiTWVDu4d9+6pc8/btWVD/1oLuCqQyE62BQyXWjeJ9asixjsPiCjDF1TanpMOOTsLiCd45ndvQxyQQzr5IT/aRzLIjdp1TEAJyhC4SC6hEHET0DMlabou278GptLXZleatoCBnlgxUjPSDrtal04bFGu6ho7uA/KDpAM90GnJxKTrZ/0iNctctUpZi0KlMsZn0Dbz/Kg52pVjCC5QUvNlEb3mly/DEg3KzrWyVkKcxJZvo6OiNWPzESqOVolTJ9nD0UeoXE7SfygEJCrkp0H6EGOb1UuFT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jPMz2tVI/FMbDhYJZsqHAhq/VD4UANM+LOK/VxDiFc=;
 b=cfo5DGY7QFk9MKqi6+7t0PjcFw5h7E9Fv3itqYXLX3aet7w+5IuHHjFIXKjWRmTaK3QOkOlx0prT7Sl2UBq7O4Fgbqxj1NLbcdgSnl8x66bEs4oWJUYzMsX4mOquoAMCpn4wBl+Lk15NmxmWbmJ//w4I6E9wAozPZWFgxdM1pAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by MN0PR21MB3703.namprd21.prod.outlook.com (2603:10b6:208:3d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.12; Fri, 9 Jun
 2023 20:39:24 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%5]) with mapi id 15.20.6500.016; Fri, 9 Jun 2023
 20:39:24 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] scsi: storvsc: Always set no_report_opcodes
Date:   Fri,  9 Jun 2023 13:38:21 -0700
Message-Id: <1686343101-18930-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|MN0PR21MB3703:EE_
X-MS-Office365-Filtering-Correlation-Id: f205c07f-0083-446a-63e5-08db69299c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MDPSV2CBGX9HRpEsDMd6P/r6xej0G4FtFirGXtAqPOg1PvNzR0fi8cixze+gJqhhYfT04AB94jhbfq7fAbzuFmzHOBigAIQsM6vGvJX9rz6A1w6f1dF2MfXrYlnJCP0BzX6YfPiG+U0FKe4+XW7WeqsC7lbJZ1HBQl+dkFRr5kexJfFBvETNfJrVubHzt3w1r0qBE9rWolcvJDsbYmHosJhk5404YzTAWRY0P/w0NIvbeueT+myUPYB90RsTeEDHw911hzh620QvywTmR7k3lUzufPkpevfKTlVjogbUwUjR0FmDwgKGQ62ce4YqP58oKpRcJ06ylHrmfZw0K+v/JMLv40tVPtu9eI0/CYvwVjGhT0A0dphJWqhEdSaGJOyOSNtMwdMXHWRWd1nqJo8Jzpey9w4Ga6ZTW6wytEMRjQbbvxU38vqpQ7BwtzfODwZ7I9yV64BI3mcFJbfcvPFjjrnc5h7rowN6QyASciQFF6hH8VnCmifsX2A3rWlIaOsa9UvTaC99xaoGanCA6KgSEXr/RbDN3IpIMJCnynB/Rj0h22CRN/rDIAA+gLqqPq0okLEv8YKx/HHDprmjNrOC59J52H2p6ed/8DtfPoc8gfgQyp8tvddEdYTGLK9Pwv1nPSfpdyPVdqy/q1cEGl1hTOHNPQ2e2HiuWiN6e53J8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(10290500003)(66946007)(316002)(66556008)(107886003)(66476007)(478600001)(4326008)(36756003)(86362001)(83380400001)(6506007)(26005)(6512007)(186003)(8676002)(8936002)(2906002)(5660300002)(41300700001)(6666004)(52116002)(6486002)(82950400001)(82960400001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ADB8vGoJPDrZkTql1eSFuTegPPwMZnK+CS0A19qs2+hk73poBDNgfrMyZJjz?=
 =?us-ascii?Q?iVg1wbLf7zzIto+AU22Opb5EbFJwk2HmVZI2CfG3ac2x1UuS3f3baU1EZv/+?=
 =?us-ascii?Q?1Eq9RGZAXZwCqaU05lzjc03rGX9NW4oxtR5bruYObVy77VGDXy4qgPtOhHmG?=
 =?us-ascii?Q?LIiwWepRnhYeAsS/xbEVcFv/ZK/UtKOcbr0Slalw8NZkf1nGKpGY/dPKGn8p?=
 =?us-ascii?Q?MaGvd+ZsmCkge9buZztDN4v4dnaephGrEpcwsFgPZMkyC70punpFFL9eclKC?=
 =?us-ascii?Q?sX0S6WJoXCf4Yu8MGDaUux/pM/mRRa2S7PTku2R1i+SFAH2O//vWlfHq2cwR?=
 =?us-ascii?Q?jpEboIhv+6x1fvMepdkrBYbeDsHeOGPB0NGoObZfM0FSxiomPkB6eeaB76T8?=
 =?us-ascii?Q?ionOg8oQHDsxk2bDIU4xF5crzLf9pN1PqV3Z5rMnPY9IczFANK/EyxCfXj9i?=
 =?us-ascii?Q?j9DhnwrokUGIEPjNpfWZ+EZWL+0iGPWTBzUXmzUpUtRo1xP8XHfjmnyutGl2?=
 =?us-ascii?Q?IXdnXjAgKySEkjnhCMKShvr/+3q55/THk2lbZOXizijqp2h6kNPWPL3c4J9O?=
 =?us-ascii?Q?5TK3EVOLquuYsHxzfxh8YoMfDQMaRQadqIHQTRALEWMKn5XKosZ7YkHRBZ4p?=
 =?us-ascii?Q?FbwDhCrwh/QZabx4TIdzKYxsbt3nUwrNT8QKjhpZe9CJT63DuKmbnRRLKh2D?=
 =?us-ascii?Q?hYkMHGdtxLRL6mmCeH1wI5GiQ8hcydWqkMRStAhYIYgwUXxsxG4Gf86Tt4d+?=
 =?us-ascii?Q?k3i8wnAbI6PcIOYGF5Ye2ldIzKg/VQtuByLxwzp7c0fMlWGtetzUngXlPXoq?=
 =?us-ascii?Q?vs/K/TLCPoJI90GY6gfFNQjUj50VDRr9+JURJrHZwyrrxeJAyEEWY9r54ncq?=
 =?us-ascii?Q?mDgjCmPSmRWfQ9ydR6f55J4H7xRJ87Uj3Dz/Qv5zhHUU2diyZ2cq332/TRi7?=
 =?us-ascii?Q?ZGRkwwWrBBbyxsPuFvWqzo56T/eZzmuZkFTBs3+Vb8Wka260xXwvOVEunk2I?=
 =?us-ascii?Q?S8G5Fjwhzg35w9+DNG75PFTcPiFJgDDr23G0G7zZzpKpj6qcJkIOMWy5aLDV?=
 =?us-ascii?Q?wSVzG/OFUgd0g9yYludBTWgnr61e7eSRUdyh2SNvtB7u0KnbeWvHT4fO9zA7?=
 =?us-ascii?Q?E8MoTOTIXsaPPDZOJiAYvxsMl1in1LyI00gSNvm6VJfs0GZZuVu4exeLk2Hr?=
 =?us-ascii?Q?svtCGVSsXVIpWzHkCIm9yFEwd49gvq87xiAaRTqPJmdwVSI+2EofOvPJ0b3i?=
 =?us-ascii?Q?NxhJ8ggHn8uJLwEuOghi0/VnYrt2Kpyn+80fWzRexsXLwqTGIiyabTj3uJUR?=
 =?us-ascii?Q?JPc70yqld6OnNjmPhK4vyyn+qX7IUY7KIc+L49Zp4Lsr7uifA02wAIYYINpR?=
 =?us-ascii?Q?KqXcCc64uicqcgpi9OY5uL5+lvLtMR+33O1mI+pkS5rmomeuQehQ9b91zM1h?=
 =?us-ascii?Q?5ZXGMy0hcDpzEpKPMkEiTlkTrR7YLt76ddg8MAPQIt9YdZfY1eGN3fOwzHnS?=
 =?us-ascii?Q?uCJgL9huqyuB/ZOigUv8MqJDNsBxrd2uTkcEWBNDENxdCwzJD60NF7pRsVNZ?=
 =?us-ascii?Q?hfv7yd7LaHWUnslyUtXeNeu5beWmQwCJhcgfXej6?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f205c07f-0083-446a-63e5-08db69299c7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 20:39:24.4302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAHWKXNT2cLY3EdfhLmckjjONHic6XmiLMZTmwhqTMfWOqKumfRBQaU5yxgHb7EdP0a2SmPVRMfw5rZjrpdTKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3703
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V synthetic SCSI devices do not support the MAINTENANCE_IN SCSI
command, so scsi_report_opcode() always fails, resulting in messages
like this:

hv_storvsc <guid>: tag#205 cmd 0xa3 status: scsi 0x2 srb 0x86 hv 0xc0000001

The recently added support for command duration limits calls
scsi_report_opcode() four times as each device comes online, which
significantly increases the number of messages logged in a system with
many disks.

Fix the problem by always marking Hyper-V synthetic SCSI devices as
not supporting scsi_report_opcode(). With this setting, the
MAINTENANCE_IN SCSI command is not issued and no messages are logged.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index e6bc622..659196a 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1567,6 +1567,8 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
+	/* storvsc devices don't support MAINTENANCE_IN SCSI cmd */
+	sdevice->no_report_opcodes = 1;
 	sdevice->no_write_same = 1;
 
 	/*
-- 
1.8.3.1

