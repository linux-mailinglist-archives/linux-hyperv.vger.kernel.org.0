Return-Path: <linux-hyperv+bounces-10047-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGneIVoQ1Wl20AcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10047-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 16:10:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9B53AFC34
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1D53303AF2B
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2D315D46;
	Tue,  7 Apr 2026 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdBLf3MK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7CD1FECCD;
	Tue,  7 Apr 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570616; cv=fail; b=BgVJbTq+REEFNCbZ1OqPDMsdnlMAvriUy2jXaRPUWCvrxsKNnDFeoSUKySEcmBuuCPL66jFCbxBp19Sdzks7MaCeF62lBNd2nmyC5VY2kk0r7E1mckGZtolsDjDFuK3ktFRKvyze5xzFBKc2vBuFYg8zIGjuWZ8l1yO0txtr0BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570616; c=relaxed/simple;
	bh=a/m5M7VdnT1xyK/xE97TsljA9JyGm/TjUGkrMXLCxEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YW/0kMMdLr+RlrTHDPEbvSKiI/yRufP17bq3f2Z6fziJ9BNysIKjvVONgR+pdmrXKflMCdmgcMxZka9a0Rpu5PLCUMKlNvdla+24PdBSc5Jj0HWhGLikrgQAbEkZTYVVyJo1ApFaFqlNH7pXIUZRJoqHpydspuWlM72ZHKXR51E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdBLf3MK; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQRVpQ6ipkjd4E4dWvWKm/ZIJANZfIgcMcPwYg55k4myl9s/sqgLK2LZosawtDw8Te1Am41xhftr+76NdTo27x0qNzU0E3YKRbD4QkxuIpz7jQ2a4CELpXY/I67nx/WghpKd5O8IdBIRxvYTqe9ZmRKhei4WTbAiTr3mhvtaJMMsI4FGoGXko/cnU8jhlOrd0C9tqDxnaXXFda0/eU/qhJAH45A8vzsmjX5qq9l/E4z9eY5ngw+HakvnAitmTXlnoA9kaL4Gcr1tnBh8obV/pFuCu7WYCdEfx2tAPLN6uyv80R5FOyTWiMMf40Yzo9OXwVQpIyn+Wt/HdPxai1wlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXd7N7riOcu6JXsLuXzPXWGCBNL8AZE3i4QOARgUKII=;
 b=MIR2sgv1iGy64RlUeOT5Rxf5IwdPA2RXLcx9A3w2tiADXziuHYmgNWfthoTJD2spRV+F7SYe7OEInZW52GDzjHvPnnFotxN8YSxwK3zUyuR3q1UoqmpPllSxneN8EePO3zECUB9q1sgHj4G+dJfBkinUE37j1CURnd28pLmsJL5iuwMpD5q11lq9OnPkiQkzcur+3y3cHHZsu0AsHd8sFqbVYmYnYmycXtk3COoFv2fzT3oyRM53LRCDYAmK+N2wsqt7lIMaCWfEEFs/9wvlLjHImF52hdY2p9CV/tn2DFpPNB+GEAmaytjnoqSxyveajKQr5qCoplkbZVO0yPmfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXd7N7riOcu6JXsLuXzPXWGCBNL8AZE3i4QOARgUKII=;
 b=ZdBLf3MKpF4/DfjameEOIDSs5jkk/utvf3gPu2BDdhyCMyKWHe+T68MibFuhTr6HhMonyJ6vgDDF07TxJj2Cd0TzmWEKlQedVruSVj4FSR/+1jKvX9UmYMCB5YyQc7HNw1HR2i06POaDYOtd/t6+MzWSc+o0y0TlNi676fOD69o2AkE+g7kYqDJ7v+iHOyQ0aPfGLu74+BkmVPQ+fAPolgAT2dUI057ui2A8qRfFD9SAX4ieQhJCwrPlu5cp91yYn3VXxnDXj689tFlhSmoF1J/iUtWE0ir8zN8X4uzD7RCKmpvV/DiCUp9vcetKzBX0xHBw+PVJ8g2otvwWO2aLhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 14:03:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Tue, 7 Apr 2026
 14:03:27 +0000
Date: Tue, 7 Apr 2026 11:03:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>, Adit Ranadive <aditr@vmware.com>,
	Aditya Sarwade <asarwade@vmware.com>,
	Bryan Tan <bryantan@vmware.com>, Dexuan Cui <decui@microsoft.com>,
	Doug Ledford <dledford@redhat.com>,
	George Zhang <georgezhang@vmware.com>,
	Jorgen Hansen <jhansen@vmware.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Parav Pandit <parav.pandit@emulex.com>, patches@lists.linux.dev,
	Roland Dreier <roland@purestorage.com>,
	Roland Dreier <rolandd@cisco.com>,
	Ajay Sharma <sharmaajay@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 06/16] RDMA/hns: Fix xarray race in
 hns_roce_create_srq()
Message-ID: <20260407140326.GB3357077@nvidia.com>
References: <6-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
 <f1fb94fe-c86b-7866-d606-088343a56fab@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1fb94fe-c86b-7866-d606-088343a56fab@hisilicon.com>
X-ClientProxiedBy: YT4PR01CA0249.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0ee7e4-05a7-4298-a38f-08de94ae710d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Y00Z0qohceGwPLvzzORQUskEpyA/8EEP3NoynkIbTSABeysE6h46bYZwId7lTCPZqGVZhwL7A79jqK4QCAemPOKFCVxFHxVr87LxOhp1tmNtCmX5dXnB3faindZOOlNClrZLGnj+s4vuK1Hx4f/X56Vs7oUkEZObOy3ROsOvWQCXfEwxRnoAVsQN6xTIejFcpe7gDYprX0gNYhcwfXKu8dqd3jJ9s8Se8J6S9TjB4+Y8m1YYjjXm+M3i1tOyj3c7klySk3jnZXwEqcz54GS+tNNxNztYY8VATFmR5publFx3hJkeCQQ9+pVuE9z73D/s3bwiP4+QYeX1pvSI+fqipZAKymiN2IJiXo47L2Yp3ubVIbMLKJdlEtl+D0hZP2WoyZhh5WMB/fKYwUI/hkupuLQ7Oy3w6ei2FgieQMlXmpAxXI2SeMMnhB7MNQs+qw5qHQSw1Shn2+5tG7cLDKMODtLMLYPKb6hjNv55C85V7X1cv2Kp+JM8wAu33gFhl9hi9QR7kjedoQHXek0EX4XYKijSuaI1ZPLgCJycaQ7K6LxNe0HFiq8CEluHIVn/n4OOf88T+0heZZRmpCiiBD1hb5vu3dDXwwPmvx+fZqOm0NC4f59U2XCezJrXGFO4UAiX5rwMTt+BiVJs5twCa+/BMyoMeNkTH2E93hQnOcB9b7vNJQHIBC6eA5g0m7uX3fkVMQfr5BsOTIeUF9mTC6tA2OMTarDMqm2PZL/15ubpfLw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JLl0H6lROgv3I5faA2Car+zGSO1UvnxsaNEWGk6f7mOnS9Ogs5OwLaAx4Oar?=
 =?us-ascii?Q?vkyBA494UdiGD5ouWsWSJhyrEV3VIe2L/IYnF2xZNS5BB/aXum7zQNirrLUX?=
 =?us-ascii?Q?2RfRYw2kl4Q9woe5DR+l7uAxnzF4dqZmyV6muMZQHU+gnFu0h5AnY8j0iWCS?=
 =?us-ascii?Q?0fTTTxOwBaCk4m0Hw0bq5lzMs/W9S8Bv+h6SUaphm10QhLAwCb7IKTmx1VMt?=
 =?us-ascii?Q?UP2F4h+UVENMjqmhyQTDkzQMFEB9FXDksHUpYHVWqbvHrMztgwUVkzViIybB?=
 =?us-ascii?Q?2FG7kWwUm+WErhEBj47tVg6ygXTzuvWNMKRxnVW81V2H5PZSjdnLHQWnj96U?=
 =?us-ascii?Q?bQWc+kL13inA/yS6fxn5YjQYUHg0iXlXLRvVaMMyj+ossE1/WpWXCsvtMuYq?=
 =?us-ascii?Q?Rqm3RlQiqxsuk0DGM6M13ELRpq7kL9iki4/820sh8AS86yPk9vAs7QTEf9i0?=
 =?us-ascii?Q?c3eDZlwsoFcn3KNhZF24yJLzoxb7I1oLawqr3im/C4bAK/Rh3UUIx5yRz6uH?=
 =?us-ascii?Q?4FobP9j4YUbcDYkae6Ls9Yf2yd7GoZCgvrpy6Jbhz/iq0Y8kEh8Ho8p7IURD?=
 =?us-ascii?Q?EgIoN45jbe+ipMqwQBHgKaJFQtdQI5bWNa024/KXfO2ZHHv52ejzneathjEY?=
 =?us-ascii?Q?lm43UnZvrZSM4fYg8DIOneCyK+vehSiodD6wLgZSf44qv9r5QWYGwtHBk+1E?=
 =?us-ascii?Q?2W49yKlN5wTVvtFx4PR7TqFUmU2NwGoYQ3pQ9EO567wOcCLYDxXXpCBp1lxJ?=
 =?us-ascii?Q?T/Kccnz3Ff/XoZerOvGd/0sf4iij6QoLXtA3jAbg9Sl10svw9AaH1uERhqaE?=
 =?us-ascii?Q?gqdOsmmlV0koCclnJc0TUP7kARzbyo1phVLlOuyLfvU0fh3XWhhcORj1XmpE?=
 =?us-ascii?Q?sdwjSh0FT0SJz42oBMhSZ4hEwst7/vXraQc7CLcxHzEwOg+jVaRQarO5XfjE?=
 =?us-ascii?Q?4guAfxh2Fzp1z5p0AQEG90fs4t1iE3zRFF1cNTKnPT/SDg61tJMaDA5oop7q?=
 =?us-ascii?Q?cbxM1V3XYTvBFaPzh5iGoJ4YPPXX7S8IicAy1wHGbquSFWZgTILy7TIEMg9N?=
 =?us-ascii?Q?Zr7hV9pRET2aNLmTWX4A6UzIE2+g1Nllm9NS/ZkAla3vXxW2iQG2+rNdKq4M?=
 =?us-ascii?Q?sGV0Az6IZK0wzCpmJjF18Dhau5IH/RamE82JyLXCUp8UgS2+f+IxiqJlFykU?=
 =?us-ascii?Q?zl6obj6f5NXSCcPpD6rAHkZrTPwY2bZERca/McXC/cv7TcWHGA+xPAWkIQTP?=
 =?us-ascii?Q?3UBfkNMa7I9R/kaPM6sOHjLcyOKDsObZTuRezUBuj+nkqx3EXW/PhsBOaWRu?=
 =?us-ascii?Q?XomF4CMYmi3lTaqCDYyrCMRtwGEg2EDaDmak3Gld2QCKE1Mgebixjf8H8UBw?=
 =?us-ascii?Q?yjK1OQLvaYOunCVkmbNXnCM7Z8hkiweb8S0HABTV5z0341YQjDMmTu7Qybna?=
 =?us-ascii?Q?cA5dH/JwC90LpwtBgbgKL2W3TW8Eb19qPHU4XfRXhkYIydszy5poNv1Gw+i2?=
 =?us-ascii?Q?7qc5Kj6d4b3MEfxtwl+IQQHQEhsAiw44ltKj//1q5SDKyNj8R99Yd5ggckjA?=
 =?us-ascii?Q?ZroGBNKCxZ89eWwdm1vcO5lAJfu+87vIehqAmA6qRXmhHcQcznpL5rMUfYUv?=
 =?us-ascii?Q?CkDqvJoekHoNtWi/cchB1MHcjSIcuHVJ9iojwhHnrTRJyY/OM2E+yepK9E5t?=
 =?us-ascii?Q?0i+lrovL8pGc3ba6lFKUc35hS2Pa/FiCIXGWpeRgvbw/vMgR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0ee7e4-05a7-4298-a38f-08de94ae710d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:03:27.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ws19Kq3H6C3gU09qhHl6S79YhgGSbTXPNcazavJdoq3fecN8dJAncUXou7SDf0c3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10047-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 1E9B53AFC34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 09:39:52PM +0800, Junxian Huang wrote:
> 
> 
> On 2026/4/7 1:40, Jason Gunthorpe wrote:
> > Sashiko points out that once the srq memory is stored into the xarray by
> > alloc_srqc() it can immediately be looked up by:
> > 
> > 	xa_lock(&srq_table->xa);
> > 	srq = xa_load(&srq_table->xa, srqn & (hr_dev->caps.num_srqs - 1));
> > 	if (srq)
> > 		refcount_inc(&srq->refcount);
> > 	xa_unlock(&srq_table->xa);
> > 
> > Which will fail refcount debug because the refcount is 0 and then crash:
> > 
> > 	srq->event(srq, event_type);
> > 
> > Because event is NULL.
> 
> I don't think this will actually happen because HW won't report an SRQ
> event before the SRQ is fully ready and actually used.

Probably, but also maybe there is some crazy race where EQ event can
be generated and the SRQ cycled before it is collected..

There is also a second bug here that Shashiko noticed on this patch
that the order is wrong, the goto unwind in create will call
free_srqc() but it hasn't yet setup the completion. I will fix that in
a v3..

> From the perspective of coding, I'm fine with this change, but since
> there is similar logic for QP event, could you also apply this change
> to QP?

Sure

Jason

