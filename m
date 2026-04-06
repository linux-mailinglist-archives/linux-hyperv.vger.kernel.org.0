Return-Path: <linux-hyperv+bounces-10023-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKU+Hjzw02kjoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10023-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D93A5C4D
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 688BA3018431
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50E39183A;
	Mon,  6 Apr 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lAsOWd5A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97923932D4;
	Mon,  6 Apr 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497256; cv=fail; b=OQl7lS/aKTz/WrypY+svsEXSb80wFtNMkAIDwkjxbNtsXc9smN3XG6Jry1RChq58AJSGx725mMUE3hQTUZNXvk7eCwDUvSpkWqELFiTlJV2cixyhJhWS0E4+RwfTpY3TF4+vxVVxivVHOBirHp9t6hJqF18+17TuWXX3ewqzjnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497256; c=relaxed/simple;
	bh=ubsyr1g8W03QK8fXWcIYOttYhfLSNYPXJuyBVFsa2KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t1bkUTNDzhOvNCLTeCr/j9OHUFB2lJR35KCe7AT5i6G82uO6B4yLICSS6mQUr9B0ztjywAL2JkaZtyTybxe2qXVgYl/MHIpd2tWNqqiENqSYSM3+odRnUYm6FL1UN6QZLiOrS1ZXSZyvDK4ahjKomK7rv/+sl0pIA4Pq9A6se6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lAsOWd5A; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOQfWbJx/NvCKEOCUrK2cVYDrEBJfnYG2MCll/uoV8GAYHn97BAjRtT1+k/LGI8vEhkTPIdRRgzK79Y5D+chQf5LSzcEDVvSmMSvom5iNZZtz8aOLltLSX97AVpOJKN62QJ8pDVTRrtVf+RAjLcBMdX4SKY2mgiUfZX9NtRJLqJY3SpMlqZubZ7pMTtNiFolgcdhzrHkQivQtY3K/aDjwJcj8lAqqBZvYIVNTAWalVKGDclP9vLXiOzVvATkW3Ne6o312qItlcJiqLe7Kl9l+PxyZEQUAQ/LgQRYm4z5F0SOiOXm1S2rFG1rY1WjWIYqy9cy8DWnfgHvDYSoKSMwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2YJW8qcew8KkVk3MGe4PXGHiCJdNcPUSXkDtXrKy68=;
 b=BwRjPar8WJ+WGWCq2wGoL6hFuZBsClUkozybqkFc0u4CqwVc9OSQa1w2BGcfYU8Jim1Z5DSgM47pBZM4EN45gZ66OWeyN3FoqVqIUK+ewWtQxumVrwH3z2ZTjpuDCxLwGg+Vw2GtnFpXeyt5V4YoxH3fgxDqaJgDnjda32tRdQLaU01U73nIylwVwI2wkdNik5NDQawFkZlLUNOHFzgP9Rwu0jxtsPyk1tso2cxqUH+UBSeWZ2e0IkKoj8Kpmyvo6VvQJXl+N+Cpfu6zFanD/VBcIFwNTDkLqJ+73noXPMAUGLeAdY9eQdnP9IARXE1MYA4o7o7wlIHEw/6ELkbBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2YJW8qcew8KkVk3MGe4PXGHiCJdNcPUSXkDtXrKy68=;
 b=lAsOWd5AO6nVxLVjnjTvGzE2r4pdmJaye+elrNYE7YqvQJngDMB81hY+ToHY/atT8nhsh9c7VTn6+wSgzDx3lSs06x7REUOJ/23hMRcUA/DXEMuG6SpMaX/1Aq6MsUqHbOH4PpNFtrEdurfrTe6moN1wmTWlBWyFJULyNGUln0TeuUdVSGQYEqmeCaJ66yRIEIQpWmyJLoH3ayAFPUF6rY1i6fwmNdEBTzJIcp0qRbfw7nK/VHg/Op23J/Rq525V5dI0NXysS8bt9ILljSM6hFxOKFPKwYCfIa5CDgGjDtAdi3/U4TXtfyHbpyjBmKiNE3ewSXOCYjYeu/YqAHrHuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 17:40:44 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:44 +0000
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
Subject: [PATCH v2 03/16] RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
Date: Mon,  6 Apr 2026 14:40:28 -0300
Message-ID: <3-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a55b63a-c96a-472d-664a-08de9403a061
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	/JjV6NY4uWNu0BS1DRZdrTqUEGtKJ7UCBhxy0k6is067A+zVQpD/MhDXDFc3zBpNYdn5J38WhkdjOQAVmPt4X/u+UDGWN29jRywO42TZ8KLHIogbGrIdQefB0a4nxI237xSPWYSFzVqOoL6SNBbQubFZoNXDvw7hYDmgEFJcALHpOu+pladkhJJHQUHFZle4lo1pFqDHokCJxtO94HZk8sryWijrxXhlAXTgtCJJANTz1ngXHT9z2GQEWqBEiHnX580k1IEX/Ew7cjIFa1Q74ccuFx7D26S2a0j40bOpsGSy1ujEaAeUVcQ4Iwy+kC/4p+9lBSRJlpd9foPKB2X0+hDac3f8GkjBQGg4Qj94Wk/P0Rhu7O0REmxbI1e1HVBwrWh6uJ3tZ8Mm7yClBcKRljUnHB72W8zboH76+n9IZb/hCzWQgMci3/h+LUYkPcl3mc6btbnRbYY3HERyfDU0Lgk87WwQbiPHrdP3dTJbGYT87OjASSjajKtLi8o9cXFi4IMMVESQPGEDh5JBJK6KtzsGeV1aP7EZl3bdPcpSUVImfncfRwyxHc8ttGDQ5/u2ENXJ4oUBkDPsK7MlBpoOkoIhAnUv6UAklGQ4MRFK5QFaHEqyzlNxUpSkWOmYrIWYh/zNYsXitHW323s48MGe33QmtnnNyIB9E8/Yttjtbpv42lWzHHYmqUedfJ5g+f+tT2ccatjK4Ew4E/xAlWhj+35AEuBKiWfDg/JzgZyl+hozTMZPmhZxdPznwI1qoWNKLrunOC3795IrEWT+BqzbKQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bCMfwlLhRwBbpzd/YxljmggeDJRx4SmjMknD45ZDaUkv72tIyafMqT8GqAoE?=
 =?us-ascii?Q?WMMVk0v50DRkW2vn4B+bvKUQuBL168Wucyfs4wulMRhcpZkHfqry7r9udPn2?=
 =?us-ascii?Q?SDyyUHDmyLC35evACnjSrCfhJXKZVFKizM4Xm2NVnAmLMvdutldXZxCLvJux?=
 =?us-ascii?Q?BsgPjx0ZDKHlmt4ThKqNSajD6DIF8TsugyaLnMRvi5R6iLNNmt0J0mdB3xNo?=
 =?us-ascii?Q?KukJ7lG7b+AYnPMq8lU67rFmwom+8bdpR37e2MdfjM+fEmb4WeTsuvanduPq?=
 =?us-ascii?Q?KcXHPiit+wRXlvSKXFu8bwcNHt9sW5TGpDENie2hFyQLzSrugigRLl80LWaL?=
 =?us-ascii?Q?ll3yfeOXxVPsSzC5f34IoqCEpOaBPe4Q4KnjuhBit3QwV02dUKH2q6F4jSaI?=
 =?us-ascii?Q?W+WhQ1ZnK8mx6nyHO2ozqWX+vs0JLISjEhaw42xYCYcWBeum26wqOXQRlHR2?=
 =?us-ascii?Q?TqvFDS6vu/gweir+0VCfL1QBuITP4mbFaqkybCm/m20KQ7bXiZe0u7wZwtlS?=
 =?us-ascii?Q?cSF/CPRzxohl1Kx8bLbT3Hp8nJfzMsVka7NoBLhJtBtrtrIA5plZEXLAaFve?=
 =?us-ascii?Q?68/srBchqnO1b7zOSCz+GOC9peqA4bn2PIgVPD0XVfT0FLKrLYUsHuXLqZ/x?=
 =?us-ascii?Q?sVayTuQMdV5dQlaWiRdFow+4+j/A1ddP5nLG0WcsXHH0yzGEmfdViRMRlkQ+?=
 =?us-ascii?Q?grenP079ZYXArER0rwd+/vsPRVZUSiOcpaXWleO5sAcQQ1xyfQoIJwNhZRWk?=
 =?us-ascii?Q?z+8S0PyaR3t1SPHScjTApVttbodzbmZKTpALAcQnywA82709MWEs09l9y03o?=
 =?us-ascii?Q?E6GgXiQ4L4W256me7K01TmTXUwpjZ9zIiUWyBXe1/ryMHQNi2mZCax4LfxQJ?=
 =?us-ascii?Q?mVSR3oi1RS1KH46VIbAyUzlxVg02zjllaiBwmu3uWPg4ZaeAQ2IfU3Te4mU/?=
 =?us-ascii?Q?NSZm9EVP+KVeDt8nIzMWupTV9oJfwA6fs6RcIwFhbF/H9Ps8zAgrvB5ClXrH?=
 =?us-ascii?Q?67UxOITDf/FrWMiCrga/hKr+4TDk38JSf9nmTM8TiJokgAT0zzHnasHkHMfu?=
 =?us-ascii?Q?D1g6lSPJ59VScu7NHakwttfiIdqTYFwlEe6MOJQNg1331r74AaImIK0LC21K?=
 =?us-ascii?Q?JIJ7Ixtv4byO2wkBEqKfL8LKPmS8HzCjNMbo7epkDmpUoErLLp1Waidlr3Ot?=
 =?us-ascii?Q?0dMO1XQzTRIU+n8NDag8K2IhsarS48sorMqU6iwGJvc8yXug3E2R2h4fhMnZ?=
 =?us-ascii?Q?12mhYoNtIZcp4N6Abn38vM0fXRXcTG6bfwnoANEs+YaW9Gikp/DKddr9BjA2?=
 =?us-ascii?Q?b2rWJTneVv4+8WH3SUIPxNf/LkkasCx6p/Nyk57Fx9G9H2KFTX/pGilfhWXH?=
 =?us-ascii?Q?EKPllid4wyW/mjaQftSLRxRGBqgwA6PiKtaRn6ncW2q4NFn9NtP1otZW1RyC?=
 =?us-ascii?Q?79y3tPTqY8LlpQafvd4cRBpA1CEayrnTXGIXr3Tax19G2Jx/t1D9mXUF6jAW?=
 =?us-ascii?Q?mLqK+Yr+N0aTLoKfaJqhAa4L7XqKHyL4koBioaPsHNC5W42cjCCkNiktGPiV?=
 =?us-ascii?Q?Hb4IQP61fJ0FER5t1uYiI0GJhq5Cjn+kogDtMs3qvoVPe/IQaQ0Tb8nFKnv4?=
 =?us-ascii?Q?D35ErbatSEDgivGbKpnIDiu7Mwx0D4PTwSMEvxte6WGL7hdJe/SaGC7Gf0kl?=
 =?us-ascii?Q?stYSkvKcPNbXsvvJSQ/rDyDDZp5XMvSdf13FUcjw8fU9mHDN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a55b63a-c96a-472d-664a-08de9403a061
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:43.2521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgi8ZB9a8elxrkDe39aReVgX+PIOEE9OwYTxks6IqZnFRnjehbbLcNzvmZAYIGKW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10023-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 2E4D93A5C4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko points out that pd->uctx isn't initialized until late in the
function so all these error flow references are NULL and will crash. Use
the uctx that isn't NULL.

Cc: stable@vger.kernel.org
Fixes: fe2caefcdf58 ("RDMA/ocrdma: Add driver for Emulex OneConnect IBoE RDMA adapter")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 463c9a5703fc4e..a88cc5d84af828 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -620,9 +620,9 @@ static int ocrdma_copy_pd_uresp(struct ocrdma_dev *dev, struct ocrdma_pd *pd,
 
 ucopy_err:
 	if (pd->dpp_enabled)
-		ocrdma_del_mmap(pd->uctx, dpp_page_addr, PAGE_SIZE);
+		ocrdma_del_mmap(uctx, dpp_page_addr, PAGE_SIZE);
 dpp_map_err:
-	ocrdma_del_mmap(pd->uctx, db_page_addr, db_page_size);
+	ocrdma_del_mmap(uctx, db_page_addr, db_page_size);
 	return status;
 }
 
-- 
2.43.0


