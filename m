Return-Path: <linux-hyperv+bounces-628-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 467EA7DA1E3
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Oct 2023 22:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B888B21273
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Oct 2023 20:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1F5374CC;
	Fri, 27 Oct 2023 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O8+kTq87"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E150257B
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Oct 2023 20:42:37 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021006.outbound.protection.outlook.com [52.101.56.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A71AA
	for <linux-hyperv@vger.kernel.org>; Fri, 27 Oct 2023 13:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv1f+PSzREW1XGHvMjBDtZLF6KZLkapcNm+en88jYbGzdcO//A1iE3CCst3pZ/J4oHdBnP7w/b9Ax7CSq2t5Zc8d9TUCBRol2TMxzXM+zFOvkWB7x17vyerV+dWRkG+B0VGMzcTtpUBjQA53iEi+fFu11ANuT0ol7ABggyTr9pjrwuTjeV1LIuc10b1UB5Xv8QAMIYCJPsE6RARepA9UPJLZCg173x3pNf4dOrrYMwUorA75/1Glu3IfCfSyQNBr0pWLpvS+rRtEV20aVyACUJOfECltJVERw4HfMGYZfCiZwZmgI05OMEi4iEgqckk6WHBjYviM4HcgtAnOQounUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9H9U95BUYP/dI3xY47j9XEFQVjaqjxltELjnHPCO64=;
 b=R2z/wZhfilK7PY4SseU90z9cS763V35NQTt3vBvdhX9pjJAerY+ab4eT4ixWrhnKHnwyjiLXcDeZjoL3wvtY+Vefu9DMUVpx04irIdkomtPZc+TZcN71YjhRCtkyPN/mZWPkSlGv9Oiv19KMxau0TZ2IK1hwrqBDVk1QkkamKkZRiu/wnArC2CO3aga8cM4FO9o1ROMfgu7cn6xKQfB+XC9Iy6nsE1VnuzXRare5xQ7TY20wkJWlPGvTgaAe8Upjv3J4OjXTSF14FjxzU2WmmI82850hazq3NUSXYvOAd4PPuSWXK51Hfqym3Ab0/WTKvQs1yRikjUiCuWG3tKzOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9H9U95BUYP/dI3xY47j9XEFQVjaqjxltELjnHPCO64=;
 b=O8+kTq87IUz+E+SXtD/dGB90StH+iQ71oY7S67N9T+MHzHU0AlSFNiprL5YIoQWOS8uF5QdmLrW4brFsI8sUZ8yiFXWeDA67mUgd7wYJJmrta1N5/89NnL0b9zxDOEWR8RJfir8gvK/lmefSLlazXOlKXD5aou/gmiu9rDgdHTk=
Received: from CY5PR21MB3660.namprd21.prod.outlook.com (2603:10b6:930:2c::12)
 by CY4PEPF0000EDEA.namprd21.prod.outlook.com (2603:10b6:92f::2:0:15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.12; Fri, 27 Oct
 2023 20:42:34 +0000
Received: from CY5PR21MB3660.namprd21.prod.outlook.com
 ([fe80::e65e:f4ef:8b65:4f74]) by CY5PR21MB3660.namprd21.prod.outlook.com
 ([fe80::e65e:f4ef:8b65:4f74%4]) with mapi id 15.20.6954.012; Fri, 27 Oct 2023
 20:42:33 +0000
From: Peter Martincic <pmartincic@microsoft.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC: "Michael Kelley (LINUX)" <mikelley@microsoft.com>, Boqun Feng
	<Boqun.Feng@microsoft.com>, Wei Liu <liuwe@microsoft.com>
Subject: [PATCH] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
Thread-Topic: [PATCH] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC
Thread-Index: AdoJEw5M5b78JMRkR66oXEcz4znQTA==
Date: Fri, 27 Oct 2023 20:42:33 +0000
Message-ID:
 <CY5PR21MB366066CE916AEB5289153F09D5DCA@CY5PR21MB3660.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=89b16a9b-3bd5-4c8b-bd77-08b2d6566453;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-27T20:15:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3660:EE_|CY4PEPF0000EDEA:EE_
x-ms-office365-filtering-correlation-id: 73c5c7b9-e80c-4c6c-446f-08dbd72d3f54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j2L4BJtx6IfGFGh028W7Jn7+nUxFSzFDBAsvB7025gGhSfww9VkqpMlpIACAXCAY0D+P/PB61O3UXBrGk4xdkb7p+rx++NMcffV+47gf/r6S0jXuqG1HNjA5AVmOvJAz5PXZXwvBEOMYq1xuxTz9Sv9QqhS60Kj2kNfstjTLiY6KV6q2p4w4GXehoCpJd3ipzipQRnJmjxeMDndSaFzbapm99if+PpTc/ggzOFkuRtGbYK/TmTjb6I67t8vmlMdJplxETE48IgqpKlGTJ8zK8Dbpn3Ngjv0QFcZr/pMfLUOKcBPaNdMMcWsCv63f5s6B73kyp+giGyvNa/q99GrRSrLk3ubPOTncN3pGkSe4nIeA+q7uswixh9m+gPt30sti5yRQeaTVYWMMud0j4oZzeFWnWPy7h22lz2BqEpreT9mvc5sDO+b7EXu59YWXQMhP8ZhstbmUPrjOJW8yidFKi6dbfrdRV5JyTnALL77O35FEQx4nTZI02wMtHHzoZ2vmNFohH+bsTn7VRBdkodu4nS7MLrSvc55dD+wgWIUYB5SHz5IiTxHvRtOCDIMFyaLc37Edo8+W2brei6DEu4SKQxhkXxKdleKqAwp7aBB/U3TzaB7DZavyHnaw5dbocxTzzPgCTf0rCi2M1In48+vP/j06UHZlPInlGRt4S7l8ExM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3660.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(8990500004)(5660300002)(41300700001)(55016003)(8936002)(2906002)(4326008)(8676002)(52536014)(38070700009)(83380400001)(82950400001)(82960400001)(33656002)(86362001)(38100700002)(122000001)(478600001)(10290500003)(76116006)(66446008)(66476007)(66946007)(66556008)(64756008)(6916009)(316002)(54906003)(26005)(71200400001)(107886003)(53546011)(6506007)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dHjfWszGROGYQK3GFsu3X7QkiXqJk2OcWYkNzukHhi6FWamH4FI3Ftti97GM?=
 =?us-ascii?Q?RDAoSFYAejh22tIbyIjKAY6X3qtItUUSHQiIiSXm1IU5rSF/B2GB5NGuFi+0?=
 =?us-ascii?Q?Rd9VJbQHM0xj/o8Fd362TLwAqS2IfLeo554hXYszkdKJl6bFV/Ec8cS02I5/?=
 =?us-ascii?Q?f+OXoFENGU8n0bfFUHfL2iuQuE47po3ZIXFq1kopKWX5vHFyDwIWPAVFCAHO?=
 =?us-ascii?Q?/ggItMxra2ip4gKpYOQcXD+vdQ8mTlaRlNrDmrsgcbs/ggPzMKN7A+4pMxr0?=
 =?us-ascii?Q?8C4BoTZuUbxrIJV32/qWjdH8qOmib17WtGZynzu8DZ6oNGQcjrkEXjR0RyBV?=
 =?us-ascii?Q?Ftt/fDcReBxKgk5rlHJMKtWd6/7pjepZY2iq890pm7LcMkBB9pAQ0YkGrKan?=
 =?us-ascii?Q?XOUm30JycEsHa+MS3HHk2ZWrWOfMb3lgTur8CdZdfHrtzCwS+3HhilayW+eX?=
 =?us-ascii?Q?kGJ+I2XS95QKkecNN//qZacfqHLP3TgKjLrt+uqHs+RjtGfGsvTW1E2T/sd4?=
 =?us-ascii?Q?ynj3COF6/pohjBGkX3iMC3HlshNd98FL9OYc7Hd8RyswDCCLUkMCYhgpG5Kq?=
 =?us-ascii?Q?4oVxXsGPI9e8EorDfDuRvgECElqLhuyjOVAi6ARGApvapB98ZV3vmM4xOgNB?=
 =?us-ascii?Q?xHbK5MyQZZqciNs+YC+jlzBhXKNtYb26lgIVSM4R1kZqCzMu7qknNZ60O8Ot?=
 =?us-ascii?Q?rq0sD75jdzP8BeV53+6D4k3hI/jUGKZDq5tsgKRXjAy8Qg1pltaDwoBj4qcY?=
 =?us-ascii?Q?Zn5zO305VAU85I/3EAG3xjLZi4IaTfP38993TcHTIbCIDuYrsse21YRgG+52?=
 =?us-ascii?Q?o9WXlISAkM/pr2HQbqfJ5LopSvhe5+ag2WzxO75I3zgZjgY8H61cjsTmWlZ5?=
 =?us-ascii?Q?a3OqRgqm7bUz+km4a2a6Hz/w2UOyvfrP13WLEbBFyRImCslsfKXon5adebNw?=
 =?us-ascii?Q?LHUPpmlm6xES+xGsKgc850sNB4C/5GC/oKpEuuKKkISqJuhIeCEQeDcGD5j1?=
 =?us-ascii?Q?LHBfFApMcn40/Ml/0VS3xvjthhsz1jvnjHcO4B9kSFlpCDlQutO/dR/ClFMG?=
 =?us-ascii?Q?dtlBbEmq7FAJGqWdzB6tmHmwZxtq7FmnW2gevUefk9OLMzIDDVt+nha0REdN?=
 =?us-ascii?Q?deuhQN7VNM8L1Ap+LDOz9JnSPNso8cITcj8rsBkbbgnIgfDdY4W0+z/CkqmN?=
 =?us-ascii?Q?FbysJ+ZwkPmtE4cGtDtMTTZb82FjP06947spYprjkxMLAPGa3I+lgp+lYRfy?=
 =?us-ascii?Q?mpG2LWCTaprKW3VnavdTjpkxhgJaA6/LU625euM4Lgwsg4+15P6GczkYdXfY?=
 =?us-ascii?Q?WTUnheleht9ohSxhQsD+zHb3ytveOsl0103Z9IPO8Jteykf6T6P/FwLBL7ka?=
 =?us-ascii?Q?suix79lFd5GlTVMEiE+ztr36qCDT302keBGHBDS0oh5NVP1K97Yno/zjr3OQ?=
 =?us-ascii?Q?u/gD5lVXt2tsyd2YoykctqhDRJdlqmwVcVv3bVNPLdGmx+J9c17y6MYhKPAM?=
 =?us-ascii?Q?HYv8qEjIsutTk4TS7pq5t4qid3Cy6qCaWuaY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3660.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c5c7b9-e80c-4c6c-446f-08dbd72d3f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 20:42:33.9033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogBbGH8wcX0YvF3wdFKpZ8rojgCzI7fUOpfqo9OAhEWUPKtwMI1Qnc+J2UfB19+sAIgkL2aP7CXTkv8Laz6WDVpPR2J7g3G87GeDy3F7k5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PEPF0000EDEA

From 529fcea5d296c22b1dc6c23d55bd6417794b3cda Mon Sep 17 00:00:00 2001
From: Peter Martincic <pmartincic@microsoft.com>
Date: Mon, 16 Oct 2023 16:41:10 -0700
Subject: [PATCH] hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC

Windows hosts can omit the _SYNC flag to due a bug on resume from modern
suspend. If the guest is sufficiently behind, treat a _SAMPLE the same
as if _SYNC was received.

This is hidden behind param hv_utils.timesync_implicit.

Signed-off-by: Peter Martincic <pmartincic@microsoft.com>
---
 drivers/hv/hv_util.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 42aec2c5606a..158f5ff4b809 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -296,6 +296,11 @@ static struct {
        spinlock_t                      lock;
 } host_ts;

+static bool timesync_implicit;
+
+module_param(timesync_implicit, bool, 0644);
+MODULE_PARM_DESC(timesync_implicit, "If set treat SAMPLE as SYNC when cloc=
k is behind");
+
 static inline u64 reftime_to_ns(u64 reftime)
 {
        return (reftime - WLTIMEDELTA) * 100;
@@ -344,6 +349,29 @@ static void hv_set_host_time(struct work_struct *work)
                do_settimeofday64(&ts);
 }

+/*
+ * Due to a bug on Windows hosts, the sync flag may not always be sent on =
resume.
+ * Force a sync if it's behind.
+ */
+static inline bool hv_implicit_sync(u64 host_time)
+{
+       struct timespec64 new_ts;
+       struct timespec64 threshold_ts;
+
+       new_ts =3D ns_to_timespec64(reftime_to_ns(host_time));
+       ktime_get_real_ts64(&threshold_ts);
+
+       threshold_ts.tv_sec +=3D 5;
+
+       /*
+        * If guest behind the host by 5 or more seconds.
+        */
+       if (timespec64_compare(&new_ts, &threshold_ts) >=3D 0)
+               return true;
+
+       return false;
+}
+
 /*
  * Synchronize time with host after reboot, restore, etc.
  *
@@ -384,7 +412,8 @@ static inline void adj_guesttime(u64 hosttime, u64 reft=
ime, u8 adj_flags)
        spin_unlock_irqrestore(&host_ts.lock, flags);

        /* Schedule work to do do_settimeofday64() */
-       if (adj_flags & ICTIMESYNCFLAG_SYNC)
+       if ((adj_flags & ICTIMESYNCFLAG_SYNC) ||
+           (timesync_implicit && hv_implicit_sync(host_ts.host_time)))
                schedule_work(&adj_time_work);
 }

--
2.34.1

