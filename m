Return-Path: <linux-hyperv+bounces-10028-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIdAHE/w02lEoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10028-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 814C03A5C95
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94117300C361
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F313939A2;
	Mon,  6 Apr 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T24puJfv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366073932F4;
	Mon,  6 Apr 2026 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497259; cv=fail; b=mk0Jrvhm7m1JATwf5NBlFWcVTU6y9gSrlRqC1Up2HkiDyqF/wNbNXtb8Blu0oT5do3hFL4Bfo8fgU9v13aRSZ/+jzStxiKwEJnVHapE56nFZIW+hAcW5IsZpUe0SWHh/0BDNlFg6DexlGOyNG4gboyQh5LYHv9ZzCmBokP3N1so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497259; c=relaxed/simple;
	bh=3fgPNs8Z0vB3A5jkBPH1O8rQlzZffGeBPZj0/Vvupag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0x1Yq9KYlHmNNOqELYDI8BDd2fCXQ8DV410hItxO7FOpdAPAY88ZlmGT9qkxhJQJRD9tk8PvDqrlj95LBYcSsuLtG+mmzA0XdwWkL/kBi/MEhBkhTwtQDUtuCLrUecJflY2Jb79p9PikHKQifNIr5vUhXN5pgHEb/E07gt9ak0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T24puJfv; arc=fail smtp.client-ip=52.101.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oorfZ3I4XlV65gAtqGJfyulvESOxL4cHWLWQHk+V7xoNxYVeVIzS2kSNsoc3Na/LsTGemu4RIHskTkoDM9olCATdW2V9qJa916mtz4O5fhlWwCWIhraeeI4ueujJZkSTIcKd/IHOd7jaQopDzYtcO532vPi2xM6YQdH36p/NSD1fR4/0PzVxDk4CHDtB12Tu0cDvG4ec/rsaSKgIAJN2eWh62KJs10RF6UAhxrYj9CsEgVgHcRgOhsmPaA0wc6FPPa7sPUYkSd392SUwzHka+kvy2SRfs2915zRRG5avrpZQE7mcUhT5q/tJ5RvQEOJnCDhwlX745vn2/egIsyaRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDF7pkD5nCHjPCZ8+6Mr0nkByhs/pJU38RFN1mcr4E0=;
 b=BLy4oIry7TcGUSBszYNioVAkAYxdcx9pjTgNJ6LcvM/8Gwt3YQwJcdzupi5Jnp0ebbHdcM1O98X5C7lrFA5ITal00FW4PKQDW27oYYv1QmHUpsUJDPhqGW8/AVFBznVFFQoDTucaXEOpiBqFyi9b33ixp/Z2GCppdRt+5al8goibor7sjvxs6uaLERFycJkol12Rpr6dlfTYGNkvDspDwY30c1oJ/h4zxJNYHRnz81yxVXuS9yNyZXJVwXSq7zcIx+2p6B5yuF5AnFOmzAV7lqBmZUCNmApeYkqLsDI7A75kYFiwSG57yUta19Z6ZnN7btX0gSw9d0NGdc1zmN8PLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDF7pkD5nCHjPCZ8+6Mr0nkByhs/pJU38RFN1mcr4E0=;
 b=T24puJfvnSciP5yQz6wbLtXsErZnAL3WyUrSV475m4f7ufQHgT8Vya+/DrMS81Mm9qcG+w2bkhgph7udjiRto1SleIm/8wexPZFkoqxOtcbxOTuOutuw7yoo0tgtapMkv+eJz3s6yoT0SmM/67n0pM2j3FfWBMxbiF8c7/QGxJUV3DvwsfTzwtUv5diHV+PzZTJGzBa8a99wk0n6VbV4YBGo4trqsPuljiaqkvb0sDLupvfl1CSNdB5WvNo8cWsmNzQa4jAu1rdjfenYipZcAYFXwonzZ5t4Ejf72+idWtiU7a2eVAL28iNbTgYKPJe5kUPQ2HbJ6Qh770N3NrmrCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Adit Ranadive <aditr@vmware.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Bryan Tan <bryantan@vmware.com>,
	Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Parav Pandit <parav.pandit@emulex.com>,
	patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 04/16] RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path
Date: Mon,  6 Apr 2026 14:40:29 -0300
Message-ID: <4-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: d5714e9c-0dd2-4113-98c9-08de9403a1ab
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	SuKbcRqsthQ36Q7PvG/zEGt+UnwZlpmTurA/+8jQlG1FwChoTpRbnfdfLrMZNA2SI7Oimeq7p7Algt/bbKNOQKYFwnOa7Iu1QsSb5iXEioWcSVjAomwQ7Jc3XfQy0xrIZbej/TL8oA2x1AdCs8AjOjnqCViAZf7KxnnDQY3FWwqI94Sg7d/j0Scmx/OtUbU/k4g+KCnP5fGtHRrgNc3K4pvpWoJRcFlOSWIdA88GB06GfYgL5dunyn33Ju9ba1l55agNeo9JgM3h/Qh46/4hwltcEEZ/3YjfzDAoxfKjYHN1r6SZe2/lFIyK6U1Do4xzsf6dws+SbDsOM+UGIh22NAqi5FPZj4WGhOpOTqPdvoPdjnV1irF0c2DepkIxqrYLktcW62/Jp2+SB+OHn0O3GwqFHayEy0zMEOKZHXrl49nqYZwi5j+Hj3N9Ep3PY2dko0kU2IhgoaISWX/TZUylD6lw+kEKk5gGQ2hMCIRFsyz1I8imVEE6BgqzA759Q8BQy8ilM60MvMLmtq9mkP4IktY3p8qW1jcf6zU8tPrz1s56ok98jg5xls77VeEeWnF3NoBJNeAn5QCZH2pUSKA692JFHItGYT81PrzaXDdQDHpn0Ak6/2q2FddnR4W6ia+EWTACQDe8Mar/bsUSIW46808ZKSiYeh0oe8ntYKCHzj6lzv45I24RIn6fGT3vGynJgRU0QgeHnVDutwRYT0bbAp/bAymI8OF1Bm9PuC/liWRtFy5c8uFvG6sr3SlfmW5u8jl0UJB/hM3hAEsgmNxlpA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IYN78AKhHfhc2n8P+JIg7wOs+cgyj6X7o3mTQ4BePOzfcWKaTN7evu0wUmFD?=
 =?us-ascii?Q?BMAZ5taEa7kRuFI5c1xJ9/jKwiLl1g9E8h8nYDOLeRH/iT8DT0slwQ0VMqm/?=
 =?us-ascii?Q?63z3n3/2x0kdYtNzWkT/66aJT457ZOEYcLNsIqN/5GopInU/35xb5p0cdCSy?=
 =?us-ascii?Q?HHW621j3aSMZg8wuTgJR7AiJgB6zk5xlnO6/BVu/N/9CMp50yP/xNKAk6w3s?=
 =?us-ascii?Q?NqOrHxI6RHuiwEy9BvW285RWK0Ucm1W1zRjBzGDqym384QaZxXR5tXykcAXQ?=
 =?us-ascii?Q?77VHl+hcrA4sB57w0AA27AKEcoELGisNdeHi+NEdArWJ++DVDki+b2jUc8Nc?=
 =?us-ascii?Q?pqviV4Y2erE3jwKkJhVvlWVHCu0m2Ln4HA3TdRrTmt7KXlVpL9IH0f2FpSaU?=
 =?us-ascii?Q?CO/kE9CEnvkVhbQMk9aseM/MdnTm1SIyQapJR+ZEBslhf+cEOIt+Hi4Feyuo?=
 =?us-ascii?Q?WvtwCHbJAD9vsxDy3mSO6OIlT0RvceLosCLmaCQ2d5ofA/NH0oOV3XVTkYho?=
 =?us-ascii?Q?r5vTA5KJ61SP+hTvVwgdjiH/f6oSODbPy7KXiQASmLgi+L63xsanw+4xnK6C?=
 =?us-ascii?Q?7XLno6QIiwToHWbUWT1Bv2ZuAq+6cI2Mo9314ixAtVELwpxp+67iuo9NcUMo?=
 =?us-ascii?Q?idOrlb/stVFeuG4rZp0m9WFHqG8JBjO4ho62jZfS9ETzd/CMN/Bw67GfOIpV?=
 =?us-ascii?Q?9jRTkiiNWRTCFNjLWOtpJpW1ADeabbgbms+FPXXQV1UphDH2cf+1t5mK6PX3?=
 =?us-ascii?Q?tifOa7Tf6wzdBGshB1vO1bcUUjnC3WqaW1if1JbyjPriwFOsQ2FAK2XszXBZ?=
 =?us-ascii?Q?/01PNKeS5vbicH0bs/NWpXelL99b2yD08Xa37eHOCV1pxQFNj0I7YD+jpyZQ?=
 =?us-ascii?Q?klBU78mFaP2bi2pN2efs4bj+Jhlc1LVOpfMz9AWY/8fqyjY40iEanUlo3ykV?=
 =?us-ascii?Q?6PTBMk6jfQuN1vhDH85G7TliivDpgy3/+/iYPKynL2kHDsmosp4OsQ3p7xgg?=
 =?us-ascii?Q?GoLgRCGabPygxhJGLB0EDst3xA5HK47Kkeyc7OzDojU3oRTGWkvW+j8AVqpG?=
 =?us-ascii?Q?0wf178hSXJL3zvt0dN/agDzbW6eI1igVOakafD96wDQVYT4a4IxAIAyPADd8?=
 =?us-ascii?Q?4s75Z83Tvg2KHrZPrzJDgR7rFSXgsFtD/FhZvBw1Ph3miNTDL/ASIzjbP4nm?=
 =?us-ascii?Q?aXz9uPBVOkb7tiNhJO/zeaJM6Zm47vfjmFg75Jja79/giS/YJtXGSn2somo7?=
 =?us-ascii?Q?4kxOYTEVrrnsobsRnUoWbdnz8yT8/+x+Mm1BoGhUiJMlqd00LbDtyEdi7exm?=
 =?us-ascii?Q?CEALxW3m6uLTxg7JRIIRM7PhvhY5l0Hz7NVCzCdD1ZAuxtGJlSi27II02cm3?=
 =?us-ascii?Q?1xCRfp/Xi7oNpQREW4xaXJOtU8ybFRClP7XzEZv3/GW+aHigQ/yhpUUdxPZV?=
 =?us-ascii?Q?+wD1tRvJD7TnNhgzDhdItnBaP+sU3pyBv6iMsR8wuxDtkMMbGfkiqYNd6CCZ?=
 =?us-ascii?Q?Bc2WRhxSGbLdlZbVMiroW7ripu1q/Z2uYp8vnI8crELmB7CMAYeWYcKvR03b?=
 =?us-ascii?Q?3VUrx4qHhN/pitanap3oaWppKtkqyIECk1qokRo8g7rVFhj6QPGtshkzspBa?=
 =?us-ascii?Q?EGKIpGXuejVG29Q+A7fUmItJY/goKuwN5UwVwFx2TGbTTcFKcUU1sW6t4fDw?=
 =?us-ascii?Q?ynwOtwp/8CFjbtfVndjFc3XHPwnJ7ZYv0yp5Jw6cEC4XWDkk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5714e9c-0dd2-4113-98c9-08de9403a1ab
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:45.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZClCeQFMOzLjBXlJIH7aNG9yMIu845NWw9IycON5PSfblxcMyEbpZDdc5T3GsKc+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10028-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 814C03A5C95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko points out that pvrdma_uar_free() is already called within
pvrdma_dealloc_ucontext(), so calling it before triggers a double free.

Cc: stable@vger.kernel.org
Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index bcd43dc30e21c6..c7c2b41060e526 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -322,7 +322,7 @@ int pvrdma_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 	uresp.qp_tab_size = vdev->dsr->caps.max_qp;
 	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (ret) {
-		pvrdma_uar_free(vdev, &context->uar);
+		/* pvrdma_dealloc_ucontext() also frees the UAR */
 		pvrdma_dealloc_ucontext(&context->ibucontext);
 		return -EFAULT;
 	}
-- 
2.43.0


