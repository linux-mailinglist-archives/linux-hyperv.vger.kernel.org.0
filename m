Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE643A383
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Oct 2021 21:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbhJYUAE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Oct 2021 16:00:04 -0400
Received: from mail-mw2nam10on2129.outbound.protection.outlook.com ([40.107.94.129]:6336
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239785AbhJYT6A (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Oct 2021 15:58:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Arse1DgweE349Ot9JNcYthxmhOVhKf2HHp99WuSxiO6Qv1SaAEhFv5+W1IeTDGRjy2DHPnRAIYueIYGgO3/kEmsfj1+PuqXGvJxy8nkepYk4hL4cdVhT21xye76r3hWRJNlxjmwb0XXb3HOCM0ORsa9u59QiuxwNF0Lm44RSpSXuf0CtEp8Tv3FUBBIi06WcmA+ApIUwURA47z6N3kz9MYztsUb0B1wHHSMXS40LJSFLBtTqpBFr5QjJ7lFkU3aUmUG3TksfuXkP447K2R+FpmH7TSjH9Hs/pSrpiRcYrgrQXvfk6NxPlDHh43PQoGoc8tr8/tIw4zALiTRYc6fJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAN3lEM/3JLlWJJys7jGedhB5r+4OhZKUnRnzy6p4hQ=;
 b=n+RoYpVticEF2dUpkD8CnmnAlK4Q7KsJcRdc6nCGCTOuownNk/34uuzeaGnetqfPYnms9klt4C3pkGo6OcgHRw6+QV7cwx6r1hVKwaDHPNqXjnAnG7C5kBRNBXsefYkNDl7sEwPlsvP9rq9eaAtLaNUUpIEM8Av4o5io7lo0HYDPlIE1xaAgWoowB99czRFa5AXWhikImJmVc+S977UHRVSTr/WW3pS+pnopN8aNhb6H/6dVLFYRasW63/JkqbIUObCsa25P/SCue4RARhlt8vdFHpuOGKCi+VnukqP/SVkFztfejBUHwrFq40xO3KiU+nE9sgCBZ87DzyVOZnUaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAN3lEM/3JLlWJJys7jGedhB5r+4OhZKUnRnzy6p4hQ=;
 b=gwZ1i/R3PIeBQzxl8eQn0tITPge/p5cIeboioqNEKQ6h88eGWt4XzUQjtB2o+asAd4eUg2ndeLZGQOkp+P5UdvYA4Q0BpWVUL0HFf4LkSYn0KH5flZ37xq5mzBxbZ5QIXUYwSlJFf7uzLW+7Oz2vBLkGHWmkfVqmUtWzW44TElg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB1798.namprd21.prod.outlook.com (2603:10b6:4:a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.4; Mon, 25 Oct
 2021 19:55:32 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::16:1eab:4134:bbfc]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::16:1eab:4134:bbfc%3]) with mapi id 15.20.4649.012; Mon, 25 Oct 2021
 19:55:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] Drivers: hv: vmbus: Remove unused code to check for subchannels
Date:   Mon, 25 Oct 2021 12:54:34 -0700
Message-Id: <1635191674-34407-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.160.16) by MW4PR04CA0143.namprd04.prod.outlook.com (2603:10b6:303:84::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 19:55:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99d5c3e-6fcb-41ab-8184-08d997f166e5
X-MS-TrafficTypeDiagnostic: DM5PR21MB1798:
X-Microsoft-Antispam-PRVS: <DM5PR21MB1798B9B454D07CDD9600E4B0D7839@DM5PR21MB1798.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdM82BvPZvV+lYVrAQYVeSscgLlOs0xKcetHp9InBPFoqWPB+GXunZmbXX9XqlgkQhOCe9uL7rghG0Ihd8zx/2xkCOkSakXOWCznZrYTGA3GUVhFXkKG0FayGrM5TALKI8Oq01+gin8v9/tuhZTylgWqM8c7EswXLKbMWEbOOVVXBVgwT5ZsBC4VeFNTqEvh8tn5OnYGKhL2e4xpYF7LIdQ0qEGEJDs9CMlBe7frU7h+uMAf8+iuW36Waa5bapOgs9lzf6QHrhgaWuzG8jWvSDtIokwMUSVvN1Ehnng/xZboU+jyGGpdwx041ApcxUEkDQPmmlJECflwclqzMc/Db5wBoz1eLoqktIz2DLVCZyqcZh08mZTDYH95lF/yVIZA99nWy0v3D0SyRqxV5Qtv6rN7RPAFSk+Im3yKxwvH6EpNFlca5fQBFUDvORL2V9ZxrOXNDRF3byAFvtuH8QncntpB9ZdZCMaLcRmIfG4HNcJU08hnqRsOHQDOsYfudQuSdBeQT62Yxtfno04SMfIcix4M93CxNl9eYsjqx/T7X2iynW4oPr+gt5aQR0kIkUVgpy/+V99BHFv49GhqYjDoTL3ngtvMjeyghVjzasIkImGrOMK7BRhScAh8JQrgcXuss7u8c6k7nnaFabuFKoALuimiKXl3xQwONOIei2qG7A1VFfl/QXLy1dm1yUcX964l/gx0ohynKdx31gXqjgAZtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66556008)(10290500003)(26005)(316002)(52116002)(107886003)(7696005)(82950400001)(83380400001)(86362001)(38100700002)(5660300002)(508600001)(4326008)(8676002)(38350700002)(2906002)(66946007)(66476007)(8936002)(2616005)(956004)(186003)(82960400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sQd/voAkp4aZmV6PbK8FwePCKtRZ+knqTaul5Mwrcx20TreHwRPV+Qn3jlwu?=
 =?us-ascii?Q?dtAjiX2ZfPM7agYJr+1ISQSG95/5Sd3LbxqySvrQmu7lOHTJ/3TrQItIgDsP?=
 =?us-ascii?Q?US4auR2xQ85vOMxFs8ZOP+tG4e7PGS3yIL16DvzBfY0iewokD1SZN0sDk1I8?=
 =?us-ascii?Q?Mx/bLvVvX9igEa0YExLKvG/c9XnLEpYqSgQHu9i3c1PbLLOVLOBR0gauV7GM?=
 =?us-ascii?Q?SRkjsGAWUPnVTqlEQmwQrrZcIH3LCf8a1NWP6UbsN0TJ+KB9yczeWvukWIMf?=
 =?us-ascii?Q?ljj/t2Y8CsE+Dmzbo07Z0MkKxTygQpYlReOSoWE4VZumHVnwWKcCQi1UJQ8s?=
 =?us-ascii?Q?SCcPxcP+6N4cFbgH0l5kJrF4Eojgxa8MGQGjGCf3SpmAxviCLtlemOL0pRXY?=
 =?us-ascii?Q?WzSky02BWnzmQHkuRlBzZ1vsn7fRWXVJycPpOBbDM53Dl48ZaehEETt6lqf7?=
 =?us-ascii?Q?Ogf14sjlood0kk9O+ZGI9BnEjSm4n3PSjrfFo8N4VuK7yP4tRbyNijBe8qDP?=
 =?us-ascii?Q?CW/YvDAR+CUzthjZ70l8ZCa+xYmdpWcJVGcBIq0ZvU6e69g5wjufKluPkiEr?=
 =?us-ascii?Q?TqcvC0m1Q4tp/8vOvkhoX9c76qEmxKU153zSBje/YHYnjUb9FcCyHjJd3lCr?=
 =?us-ascii?Q?RVrXrNz1Z9TgHjxczeeXPI1lqMo+94yLaOwL53bd7FrL6UkkeOGX1sKii8LV?=
 =?us-ascii?Q?wboAGnUU/CudNoH3hKM5IQ8OFcqaCSIh6sKkusLpi156p9+0jwDxDPHQMKEo?=
 =?us-ascii?Q?yzifSnDaIzJoR6/CFW9zsvfOpWvfhMdI1SiedsG47kZvboDTx5Jl75nLmwGw?=
 =?us-ascii?Q?w3vSNCCCkzbb6Ha1uOVpOshFbwFEsKfd6YdESEYZExHWlGI54WX8pbSe2YBM?=
 =?us-ascii?Q?ccUb6CF6EzgJTwgK2R8Zu5zMQLBMLo5ptOEbjYoSbZs4MKk+I83Be2xrhi2m?=
 =?us-ascii?Q?ET2fUSINDAoGAqwlvmXPA/aagj8cBw4rPPaNf8eyN3dRkmJZMW5z9JuBi7Jq?=
 =?us-ascii?Q?uCc171E9xXiYzbUJpZK9EyT0O1UjjS1J1cwDHlzQxuwyKxztEg7kNTogY/6L?=
 =?us-ascii?Q?Xh5n1QZatTEKIyuxi6mMmTUFglUX9HWgUjTz1Pi2FUO3Yh12iN85QfNGXOvL?=
 =?us-ascii?Q?TARQ1TV/ym/X4amfrvi5+0M6WrVgmvOTSR2agDqvKddbw6n4c+59zxUxQqcn?=
 =?us-ascii?Q?qK6CLguCLP8aDZ8Ll8lO3ie2FI+gbaU1v5FZYMS+ZolqDXGPJCzB/bx+m8ul?=
 =?us-ascii?Q?WvDj69jFp03C4OYyFG/CTQde0bWF6baM6PDGz6nrqP5MqbH4YZf4xsccRwYS?=
 =?us-ascii?Q?30hy4hSM/YYGfBqwR2C/TeZAwF+/C5gVkI38GFPqAwQbeouKe01HNfoHCJp/?=
 =?us-ascii?Q?dNGkvVns0RVKqfMKgWjy4nAcYDWknUdtvucQ0MCBwgT2RN2rjYZaFFXTJ1Lj?=
 =?us-ascii?Q?E5INwqOJn99zdEidc6CuffXnT1QErX45d4tG1PfzBpjfwr9TizyCjksPSozb?=
 =?us-ascii?Q?TV8/cq5RcN4+10AL8ayrFXQbR5prWML1h2N4byUQl/Vi7iqcibr1H63yM8/B?=
 =?us-ascii?Q?P+IMeOXVIw0gbY4DdL2Lwqr0vEm5qbpv9PIvwLPK00SXlWaxJJ0svIXUGjS8?=
 =?us-ascii?Q?DBMBtxCbAFop/py3zZIOlY0=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99d5c3e-6fcb-41ab-8184-08d997f166e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 19:55:32.0040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0eRofuVBH7KV7tIhwRkcK/dbPrRSc6Ocv3cwsmxphsSBvzKOzW1tDNuz54JU6lhkm3/7rWOHuGK6gTQrcgZMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1798
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The last caller of vmbus_are_subchannels_present() was removed in commit
c967590457ca ("scsi: storvsc: Fix a race in sub-channel creation that can cause panic").

Remove this dead code, and the utility function invoke_sc_cb() that it is
the only caller of.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/channel_mgmt.c | 34 ----------------------------------
 include/linux/hyperv.h    | 13 -------------
 2 files changed, 47 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 1423085..2829575 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -1581,21 +1581,6 @@ int vmbus_request_offers(void)
 	return ret;
 }
 
-static void invoke_sc_cb(struct vmbus_channel *primary_channel)
-{
-	struct list_head *cur, *tmp;
-	struct vmbus_channel *cur_channel;
-
-	if (primary_channel->sc_creation_callback == NULL)
-		return;
-
-	list_for_each_safe(cur, tmp, &primary_channel->sc_list) {
-		cur_channel = list_entry(cur, struct vmbus_channel, sc_list);
-
-		primary_channel->sc_creation_callback(cur_channel);
-	}
-}
-
 void vmbus_set_sc_create_callback(struct vmbus_channel *primary_channel,
 				void (*sc_cr_cb)(struct vmbus_channel *new_sc))
 {
@@ -1603,25 +1588,6 @@ void vmbus_set_sc_create_callback(struct vmbus_channel *primary_channel,
 }
 EXPORT_SYMBOL_GPL(vmbus_set_sc_create_callback);
 
-bool vmbus_are_subchannels_present(struct vmbus_channel *primary)
-{
-	bool ret;
-
-	ret = !list_empty(&primary->sc_list);
-
-	if (ret) {
-		/*
-		 * Invoke the callback on sub-channel creation.
-		 * This will present a uniform interface to the
-		 * clients.
-		 */
-		invoke_sc_cb(primary);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(vmbus_are_subchannels_present);
-
 void vmbus_set_chn_rescind_callback(struct vmbus_channel *channel,
 		void (*chn_rescind_cb)(struct vmbus_channel *))
 {
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index ddc8713..836fae2 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1100,19 +1100,6 @@ void vmbus_set_sc_create_callback(struct vmbus_channel *primary_channel,
 void vmbus_set_chn_rescind_callback(struct vmbus_channel *channel,
 		void (*chn_rescind_cb)(struct vmbus_channel *));
 
-/*
- * Check if sub-channels have already been offerred. This API will be useful
- * when the driver is unloaded after establishing sub-channels. In this case,
- * when the driver is re-loaded, the driver would have to check if the
- * subchannels have already been established before attempting to request
- * the creation of sub-channels.
- * This function returns TRUE to indicate that subchannels have already been
- * created.
- * This function should be invoked after setting the callback function for
- * sub-channel creation.
- */
-bool vmbus_are_subchannels_present(struct vmbus_channel *primary);
-
 /* The format must be the same as struct vmdata_gpa_direct */
 struct vmbus_channel_packet_page_buffer {
 	u16 type;
-- 
1.8.3.1

