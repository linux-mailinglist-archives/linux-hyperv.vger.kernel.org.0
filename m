Return-Path: <linux-hyperv+bounces-10037-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKYhCJvw02lEoQcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10037-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:42:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C78C53A5D79
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Apr 2026 19:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CB5B3032DD1
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2026 17:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA43932FC;
	Mon,  6 Apr 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGdtqGg+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB63932CD;
	Mon,  6 Apr 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497268; cv=fail; b=YOuosDZpZqTCB1CTo4V43uld386FvxynwL0uCVX+KzWxy2Qjas/NMtusruC/yEm2fauk5tmiG2voIX6QzULBhYEWEaQnebHfdUJOrzSMWOT7ccYDuewk2DMWXMauXTlSYm9J0iDjR1et5pLfThVtbWx9Fo8+FMs4FzKeXTTK9q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497268; c=relaxed/simple;
	bh=iO+ix+UXSBDlGSaqaz8ZOZft8BEeij+csVP6fBs8+50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQ5F2Lmew3HoaMIw/2FN9nLaR5ltZqaWsVzqV4x3VNzmnsAYaAeXmqCL81+d1XACXd7XlwmmvWO+Zv+Xk4ujoQPK2vo1KWIxEQnDmgMPGskFJ25UMhxQUlmBW08lom4fwsTpi5ACXr3BAAltn8dzRpbvo2QwzuRa0kFouiE8qkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGdtqGg+; arc=fail smtp.client-ip=52.101.85.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA0ArOWzRuVMj80YXruvYdck/6SKrg1nrihAGNsRK1b/v+3c0zowU43zpA4JiDlSQK7uRO1kpOTeKqpm10h1Y8rF+WaWL7AdIpqsuKhrqWmhJ3NIuy//P/IADUVGp9waOYWUqxsSAVaFvYuwA02KBYf3HpaR1MTmiX8rmbsAhbq0lt91OR45bxfc42a8qFxaEnFqUe3U3QaueqBzMgQm+kspcnSSs/OKB2C0u1WY79iXQ1rrtYPyveOsnprD0LGbxG8Xrqr+fjruzhqgjorCVQ85BDkkBzZn1Gcmy+nuE4SYRT02s1fab96pnLS3dke3HqT0sWyR/Iv5NhX12mzj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPIh+qPY7UKzvAZy1wzgxL703Q/Ga5KpMoVXWFvr+6k=;
 b=Cabzx4vqmhILNNEkydK0zHpjhnI0th3Lgyzs+eH0yUTanhnAiHYoTBcj1eYM7YQkWzDWnuHiH0cqyUYg7p5AfYnECDUnwAhtkJGNl3mhPu7GkBfBg4qzEYbIYnLsnwl7NywUsMj3UIjMwbNkkF9i0iWeeKuqmT9Ayt3mJ3kVTO9ZJs4x6G7G8Zsmr+tUe2f9IA7y19uOJRBqdoruzxBGMU1letDSjaZH8oeCVeRdk8ltlsdGaWeddrE0eMiTLwF2ELkyS5iC00NXj9thd7dP9IyQ0WOkac+Hzu6B+49d8gQcP+dl3iwGDypQ5qGlMDdq/nlIizVsnLRs2i7GnPD9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPIh+qPY7UKzvAZy1wzgxL703Q/Ga5KpMoVXWFvr+6k=;
 b=fGdtqGg+H+Fb0a2YHUDyacCr1v8CJNrlA7XSOzyMUYAf2rqmqt6L1/vbzjkwoY/Z921zRtSgHvoufY3/5t837uKx4Aqpfbl2aBgZZS8kwb/o1ZBlhPsZlRKoLatOFIda8HcR6bc354Y5r4IwbexuK/Wsgmy9JHkMC6IHidVkJ+NG6QMoW3wZ2SNTncZSwfIFWcpmv05pAHw+cb79ICYYkNv7LsfXYDYLpecG73OQy7KYITQneaqZkk1UeSUGwdvG7quNaGYEBZCEgohFy6lieJ3xS/2Gu7Hro8an/xFDMIcjlzn29/rno0uWEcWhZB5LxfUcAUq48UFdfLvROnYyWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Mon, 6 Apr 2026 17:40:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 17:40:51 +0000
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
Subject: [PATCH v2 09/16] RDMA: Convert drivers using min to ib_respond_udata()
Date: Mon,  6 Apr 2026 14:40:34 -0300
Message-ID: <9-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
In-Reply-To: <0-v2-1c49eeb88c48+91-rdma_udata_rep_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0081.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: ef58a702-cc37-4126-cff7-08de9403a32d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9s96uEZldoW+REZCKFvTebE4rcwMvlylnIkdM2mf1r8oaREMUaxbPD5M6M0+69Frh1XkvBk/TuB8hkBwpQe4HNC0Eu71bQlgncqH62tvcNitJsYFpQyYFyb6+TeBVOlXmOe2vj6PH0zWhvc7X9oLX36O6191kK74dD1LnnBvp41DURiRHvrQ/Y3W7I4xqs2UtQv0JL6+WYdwEDKs5Mcgq00TjI3samK3oD2LhmCx3gRNi45O5/dONX1wZLXofzAAEj5b0WyUZ1TsjGUgmm4deeN+1obqGnNXU+Qpx6lO5DDG1BdnRImlieSOyPLhyLmMdBhsi4CJFEl9rGjsJ6EE1DglvvVZQwCXGQwA27mk106Rs0m5kuOlcDFM9NyTE5tW3avHxYTQGRy5xOlip2Oh+nJTP30WRQqRTLG92QXRO7e/ksakBNJYp8AwgS3T7FQBumh7TUc612txgWswJzJQnNWSDDua33vCfFNUukvDNlZemAvS2Igs0pAL926ufW2O6ATKYhcGqg6JE/tWrrGr9Dn7Olec+KLOAeW/YTVsLeBLLn4hQ+2D7jio7OaZAsdf6CXsF3GKk5kl8ny454lfUQ2ezItKwnEM27qXf6U8rv1cg2OGySpyKdPUs43quEPaszyZhCvE4QZonhXK3PWN6hkXtLzOsLPFgEeb7C0/loMSoS1WOUw7aFRV+4DoA14vzQFGoiDNY6vSk5A7RIHA7a0E35rw9wpw7tcraHihdr8+Mq1JSuOzw4vcxGVpzZhc15vj1r5ACXlj9AT+iIHOWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+2U4CcdKGNLxon6MqVOTogQ2XRExsoenau/5uQLB6LXc+KtJOEsQrTKMYpI?=
 =?us-ascii?Q?X5iTjlJMGrr67oD7NKJhMZoK8I1rK7FvaXXGqIWwnV+X6pur+Mt6xcvamVFw?=
 =?us-ascii?Q?HIGu3cCuYlitMvcoyNLNGckCavrRxjh4Im9a5vUOmdMDlL/dvIVbvga+5NO5?=
 =?us-ascii?Q?wnSsl596iVr4ZNmIuM63y/7zfQ9cBMxerNpe6X3O0pFT5HyxSEY6uM2DfSOl?=
 =?us-ascii?Q?SVmqBZdZ/MXQ7EH2pH6XiuvcS5bB/UmN+2ut0JKWzlmV+xKw1mE8zUvomDac?=
 =?us-ascii?Q?HXE6TKPh5ReMyrr27t6iARHJHmdScAi9c4lkHHOAwNJRjlzpsxCuN+yZ3qjp?=
 =?us-ascii?Q?GZIFxHFySIZAImmgHEK7z4NphSflppfR2dHCoVlyeXbsq3/gAJIiKMv9HfEX?=
 =?us-ascii?Q?DuxgxZ3NIoHc77B7MbWkFqm2aMzWrpkdyzaZGYzIGOv59hRNxhnnj9CoEI8c?=
 =?us-ascii?Q?BQQVrK+8Zo3DM/zS2fVWn/vMshzFcZLQr94ghA85msc+4QS0XGRpfAREnSxt?=
 =?us-ascii?Q?6i65J73gysiQerB7uPMYPHt5bmIKhD1QKuxL+2tA1gQj+dYNKKn0AkG2+294?=
 =?us-ascii?Q?vk1RYeJKTxwLgzR/wi1QXlwB6gQNq6Mo87O8p5bBerB+hvWQaaf7P7TYxxDw?=
 =?us-ascii?Q?NJu2YpR74fzRvN9M/dbGo67ua9VG5i/jbBPsuCEwDSdJWWkgThekxcNQX2o9?=
 =?us-ascii?Q?+bYjEPM1kjDyhqHFwM5aWMri6HhsOR0wZKXFDuSfsSeRBhdu9myO54ssifIr?=
 =?us-ascii?Q?LjvwCeiRezl4epzWT5/2DjN6RzIJYwFUTgICvXmxZQShwzP6GlrAZ2agBCji?=
 =?us-ascii?Q?CTzfYzZlCoru3DgaLMdvmV6b654XafX/hGR5hevLZjEEP1hYbWR9kdZG1fze?=
 =?us-ascii?Q?b0w0HG+/qdKHHeWm4y9sxLm7IZ1BCQIpDboO4Mtlr49B2v+GnPQpos9XPmaP?=
 =?us-ascii?Q?Fy5UoQQvGP78FTYHP34DrFejBBUP+GSFvTc6MwSzbTlrkxAeP7HSCZ8cgIs8?=
 =?us-ascii?Q?n1quo0slnbH1e2aJvOo08XMFg21D79Od03R9XnJnCUVBSEnmvrDvgtTnbelb?=
 =?us-ascii?Q?KyktlKwbYTjEPnX1kDhLmaKzaVFeYhMLauojg+7EEipZCwRXuLSt9ChG/dQO?=
 =?us-ascii?Q?AY2i2B3GAOFU17TFz/MHsi6KoNLNoZ3CLqhmRwwad2SsJ9gnfpkG2s03kmeW?=
 =?us-ascii?Q?G8NShCOMG9piOYHDkZ667Fe2EkffOgAmFbaaYR/31c8subujDbdozhwKnhlp?=
 =?us-ascii?Q?BIYD5YnELcMOoLn9/2jzGD9/fLKQ3sbOBOQSHW5ZJReh8vZqo4gvqgFwpOW7?=
 =?us-ascii?Q?xSZGpYETDhVCSqvop7JdienjikYGb9NzG5HwgI2ZJysLRqpENk8IGkit+RJb?=
 =?us-ascii?Q?Be8aTWtRXKIC3cX+BOdkpx034Zf3eIM1XfbyrrGnVodlAmPszXUyhTfLc1Hy?=
 =?us-ascii?Q?HlCmr2TJsqLUu+in7gHRX6ShPJdtsRC5mcETdenK9pGq7kqkiP76AftsOpx8?=
 =?us-ascii?Q?WMuAfbOzJCHRSo5zCS0fLqcHBWWHepymC5/JT2axzCE3jVYEZ5BQJa3Ol9v+?=
 =?us-ascii?Q?NHBpsFykTSBXCYE2hCrl3s29y9Hd8nG+WvZ58DqKj9JKHhKTQTkDST9tMuPM?=
 =?us-ascii?Q?IEaqh0wIQvXk42qP6qlHZd/yQQIKE89OzXHqmAebwWqild3DTnLtfRds/Cwy?=
 =?us-ascii?Q?foLOV4yKXInUlWbB93JROeDL2gm3e8nf5tPfFPeATvYMfqbc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef58a702-cc37-4126-cff7-08de9403a32d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:40:47.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDD5jKWkM1MnUgNL/MSmGXBpfdKppyzdfoewx+5jdHs91dF/huKGyPZHDv8MpjtW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10037-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: C78C53A5D79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert the pattern:

   ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));

Using Coccinelle:

@@
identifier resp;
expression udata;
@@

- ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen))
+ ib_respond_udata(udata, resp)

@@
identifier resp;
expression udata;
@@

- ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)))
+ ib_respond_udata(udata, resp)

Run another pass with AI to propagate the return code correctly and
remove redundant prints.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c        | 44 +++++-------------
 drivers/infiniband/hw/erdma/erdma_verbs.c    |  3 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c      |  4 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c      |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c    |  3 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c      |  8 ++--
 drivers/infiniband/hw/hns/hns_roce_qp.c      | 13 ++----
 drivers/infiniband/hw/hns/hns_roce_srq.c     |  6 +--
 drivers/infiniband/hw/irdma/verbs.c          | 48 +++++++-------------
 drivers/infiniband/hw/mana/cq.c              |  6 +--
 drivers/infiniband/hw/mana/qp.c              |  6 +--
 drivers/infiniband/hw/mlx5/srq.c             |  7 +--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c |  8 ++--
 13 files changed, 49 insertions(+), 110 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 3ad5d6e27b1590..395290ab05847a 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -270,13 +270,9 @@ int efa_query_device(struct ib_device *ibdev,
 		if (dev->neqs)
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS;
 
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(ibdev,
-				  "Failed to copy udata for query_device\n");
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
@@ -442,13 +438,9 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	resp.pdn = result.pdn;
 
 	if (udata->outlen) {
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&dev->ibdev,
-				  "Failed to copy udata for alloc_pd\n");
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_dealloc_pd;
-		}
 	}
 
 	ibdev_dbg(&dev->ibdev, "Allocated pd[%d]\n", pd->pdn);
@@ -782,14 +774,9 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	qp->max_inline_data = init_attr->cap.max_inline_data;
 
 	if (udata->outlen) {
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&dev->ibdev,
-				  "Failed to copy udata for qp[%u]\n",
-				  create_qp_resp.qp_num);
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_remove_mmap_entries;
-		}
 	}
 
 	ibdev_dbg(&dev->ibdev, "Created qp[%d]\n", qp->ibqp.qp_num);
@@ -1226,13 +1213,9 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	}
 
 	if (udata->outlen) {
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(ibdev,
-				  "Failed to copy udata for create_cq\n");
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_xa_erase;
-		}
 	}
 
 	ibdev_dbg(ibdev, "Created cq[%d], cq depth[%u]. dma[%pad] virt[0x%p]\n",
@@ -1935,8 +1918,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 	resp.max_tx_batch = dev->dev_attr.max_tx_batch;
 	resp.min_sq_wr = dev->dev_attr.min_sq_depth;
 
-	err = ib_copy_to_udata(udata, &resp,
-			       min(sizeof(resp), udata->outlen));
+	err = ib_respond_udata(udata, resp);
 	if (err)
 		goto err_dealloc_uar;
 
@@ -2087,13 +2069,9 @@ int efa_create_ah(struct ib_ah *ibah,
 	resp.efa_address_handle = result.ah;
 
 	if (udata->outlen) {
-		err = ib_copy_to_udata(udata, &resp,
-				       min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&dev->ibdev,
-				  "Failed to copy udata for create_ah response\n");
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_destroy_ah;
-		}
 	}
 	ibdev_dbg(&dev->ibdev, "Created ah[%d]\n", ah->ah);
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 5523b4e151e1ff..9bba470c6e3257 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1990,8 +1990,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		uresp.cq_id = cq->cqn;
 		uresp.num_cqe = depth;
 
-		ret = ib_copy_to_udata(udata, &uresp,
-				       min(sizeof(uresp), udata->outlen));
+		ret = ib_respond_udata(udata, uresp);
 		if (ret)
 			goto err_free_res;
 	} else {
diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 8a605da8a93c97..925ddf15b68102 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -32,6 +32,7 @@
 
 #include <rdma/ib_addr.h>
 #include <rdma/ib_cache.h>
+#include <rdma/uverbs_ioctl.h>
 #include "hns_roce_device.h"
 #include "hns_roce_hw_v2.h"
 
@@ -112,8 +113,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		resp.priority = ah->av.sl;
 		resp.tc_mode = tc_mode;
 		memcpy(resp.dmac, ah_attr->roce.dmac, ETH_ALEN);
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
+		ret = ib_respond_udata(udata, resp);
 	}
 
 err_out:
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 621568e114054b..24de651f735e03 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -452,8 +452,7 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 
 	if (udata) {
 		resp.cqn = hr_cq->cqn;
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
+		ret = ib_respond_udata(udata, resp);
 		if (ret)
 			goto err_cqc;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 0dbe99aab6ad21..c17ff5347a0147 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -477,8 +477,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 
 	resp.cqe_size = hr_dev->caps.cqe_sz;
 
-	ret = ib_copy_to_udata(udata, &resp,
-			       min(udata->outlen, sizeof(resp)));
+	ret = ib_respond_udata(udata, resp);
 	if (ret)
 		goto error_fail_copy_to_udata;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 225c3e328e0e08..73bb000574c50d 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <rdma/uverbs_ioctl.h>
 #include "hns_roce_device.h"
 
 void hns_roce_init_pd_table(struct hns_roce_dev *hr_dev)
@@ -61,12 +62,9 @@ int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	if (udata) {
 		struct hns_roce_ib_alloc_pd_resp resp = {.pdn = pd->pdn};
 
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
-		if (ret) {
+		ret = ib_respond_udata(udata, resp);
+		if (ret)
 			ida_free(&pd_ida->ida, id);
-			ibdev_err(ib_dev, "failed to copy to udata, ret = %d\n", ret);
-		}
 	}
 
 	return ret;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index a27ea85bb06323..6d63613dcd5a9a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1235,12 +1235,9 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 
 	if (udata) {
 		resp.cap_flags = hr_qp->en_flags;
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
-		if (ret) {
-			ibdev_err(ibdev, "copy qp resp failed!\n");
+		ret = ib_respond_udata(udata, resp);
+		if (ret)
 			goto err_flow_ctrl;
-		}
 	}
 
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL) {
@@ -1487,11 +1484,7 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	if (udata && udata->outlen) {
 		resp.tc_mode = hr_qp->tc_mode;
 		resp.priority = hr_qp->sl;
-		ret = ib_copy_to_udata(udata, &resp,
-				       min(udata->outlen, sizeof(resp)));
-		if (ret)
-			ibdev_err_ratelimited(&hr_dev->ib_dev,
-					      "failed to copy modify qp resp.\n");
+		ret = ib_respond_udata(udata, resp);
 	}
 
 out:
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index d6201ddde0292a..113037c83a0376 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -473,11 +473,9 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	if (udata) {
 		resp.cap_flags = srq->cap_flags;
 		resp.srqn = srq->srqn;
-		if (ib_copy_to_udata(udata, &resp,
-				     min(udata->outlen, sizeof(resp)))) {
-			ret = -EFAULT;
+		ret = ib_respond_udata(udata, resp);
+		if (ret)
 			goto err_srqc;
-		}
 	}
 
 	srq->event = hns_roce_ib_srq_event;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 17086048d2d7fc..79e72a457e7983 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -325,9 +325,9 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 		uresp.max_pds = iwdev->rf->sc_dev.hw_attrs.max_hw_pds;
 		uresp.wq_size = iwdev->rf->sc_dev.hw_attrs.max_qp_wr * 2;
 		uresp.kernel_ver = req.userspace_ver;
-		if (ib_copy_to_udata(udata, &uresp,
-				     min(sizeof(uresp), udata->outlen)))
-			return -EFAULT;
+		ret = ib_respond_udata(udata, uresp);
+		if (ret)
+			return ret;
 	} else {
 		u64 bar_off = (uintptr_t)iwdev->rf->sc_dev.hw_regs[IRDMA_DB_ADDR_OFFSET];
 
@@ -354,10 +354,10 @@ static int irdma_alloc_ucontext(struct ib_ucontext *uctx,
 		uresp.comp_mask |= IRDMA_ALLOC_UCTX_MIN_HW_WQ_SIZE;
 		uresp.max_hw_srq_quanta = uk_attrs->max_hw_srq_quanta;
 		uresp.comp_mask |= IRDMA_ALLOC_UCTX_MAX_HW_SRQ_QUANTA;
-		if (ib_copy_to_udata(udata, &uresp,
-				     min(sizeof(uresp), udata->outlen))) {
+		ret = ib_respond_udata(udata, uresp);
+		if (ret) {
 			rdma_user_mmap_entry_remove(ucontext->db_mmap_entry);
-			return -EFAULT;
+			return ret;
 		}
 	}
 
@@ -420,11 +420,9 @@ static int irdma_alloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 						  ibucontext);
 		irdma_sc_pd_init(dev, sc_pd, pd_id, ucontext->abi_ver);
 		uresp.pd_id = pd_id;
-		if (ib_copy_to_udata(udata, &uresp,
-				     min(sizeof(uresp), udata->outlen))) {
-			err = -EFAULT;
+		err = ib_respond_udata(udata, uresp);
+		if (err)
 			goto error;
-		}
 	} else {
 		irdma_sc_pd_init(dev, sc_pd, pd_id, IRDMA_ABI_VER);
 	}
@@ -1124,10 +1122,8 @@ static int irdma_create_qp(struct ib_qp *ibqp,
 		uresp.qp_id = qp_num;
 		uresp.qp_caps = qp->qp_uk.qp_caps;
 
-		err_code = ib_copy_to_udata(udata, &uresp,
-					    min(sizeof(uresp), udata->outlen));
+		err_code = ib_respond_udata(udata, uresp);
 		if (err_code) {
-			ibdev_dbg(&iwdev->ibdev, "VERBS: copy_to_udata failed\n");
 			irdma_destroy_qp(&iwqp->ibqp, udata);
 			return err_code;
 		}
@@ -1612,12 +1608,9 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 				uresp.push_valid = 1;
 				uresp.push_offset = iwqp->sc_qp.push_offset;
 			}
-			ret = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp),
-					       udata->outlen));
+			ret = ib_respond_udata(udata, uresp);
 			if (ret) {
 				irdma_remove_push_mmap_entries(iwqp);
-				ibdev_dbg(&iwdev->ibdev,
-					  "VERBS: copy_to_udata failed\n");
 				return ret;
 			}
 		}
@@ -1860,12 +1853,9 @@ int irdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int attr_mask,
 			uresp.push_offset = iwqp->sc_qp.push_offset;
 		}
 
-		err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp),
-				       udata->outlen));
+		err = ib_respond_udata(udata, uresp);
 		if (err) {
 			irdma_remove_push_mmap_entries(iwqp);
-			ibdev_dbg(&iwdev->ibdev,
-				  "VERBS: copy_to_udata failed\n");
 			return err;
 		}
 	}
@@ -2418,11 +2408,9 @@ static int irdma_create_srq(struct ib_srq *ibsrq,
 
 		resp.srq_id = iwsrq->srq_num;
 		resp.srq_size = ukinfo->srq_size;
-		if (ib_copy_to_udata(udata, &resp,
-				     min(sizeof(resp), udata->outlen))) {
-			err_code = -EPROTO;
+		err_code = ib_respond_udata(udata, resp);
+		if (err_code)
 			goto srq_destroy;
-		}
 	}
 
 	return 0;
@@ -2664,13 +2652,9 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 
 		resp.cq_id = info.cq_uk_init_info.cq_id;
 		resp.cq_size = info.cq_uk_init_info.cq_size;
-		if (ib_copy_to_udata(udata, &resp,
-				     min(sizeof(resp), udata->outlen))) {
-			ibdev_dbg(&iwdev->ibdev,
-				  "VERBS: copy to user data\n");
-			err_code = -EPROTO;
+		err_code = ib_respond_udata(udata, resp);
+		if (err_code)
 			goto cq_destroy;
-		}
 	}
 
 	init_completion(&iwcq->free_cq);
@@ -5330,7 +5314,7 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 	mutex_unlock(&iwdev->rf->ah_tbl_lock);
 
 	uresp.ah_id = ah->sc_ah.ah_info.ah_idx;
-	err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));
+	err = ib_respond_udata(udata, uresp);
 	if (err)
 		irdma_destroy_ah(ibah, attr->flags);
 
diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
index f4cbe21763bf11..43b3ef65d3fc6d 100644
--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -79,11 +79,9 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 
 	if (udata) {
 		resp.cqid = cq->queue.id;
-		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_remove_cq_cb;
-		}
 	}
 
 	spin_lock_init(&cq->cq_lock);
diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index f503445a38f2d8..afc1d0e299aaf4 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -555,11 +555,9 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
 			resp.queue_id[j] = qp->rc_qp.queues[i].id;
 			j++;
 		}
-		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
-		if (err) {
-			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto destroy_qp;
-		}
 	}
 
 	err = mana_table_store_qp(mdev, qp);
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 852f6f502d14d0..3fb8519a4ce0d7 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -292,12 +292,9 @@ int mlx5_ib_create_srq(struct ib_srq *ib_srq,
 			.srqn = srq->msrq.srqn,
 		};
 
-		if (ib_copy_to_udata(udata, &resp, min(udata->outlen,
-				     sizeof(resp)))) {
-			mlx5_ib_dbg(dev, "copy to user failed\n");
-			err = -EFAULT;
+		err = ib_respond_udata(udata, resp);
+		if (err)
 			goto err_core;
-		}
 	}
 
 	init_attr->attr.max_wr = srq->msrq.max - 1;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
index 16aab967a20308..cefcb243c3a6f2 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -406,12 +406,10 @@ int pvrdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		qp_resp.qpn = qp->ibqp.qp_num;
 		qp_resp.qp_handle = qp->qp_handle;
 
-		if (ib_copy_to_udata(udata, &qp_resp,
-				     min(udata->outlen, sizeof(qp_resp)))) {
-			dev_warn(&dev->pdev->dev,
-				 "failed to copy back udata\n");
+		ret = ib_respond_udata(udata, qp_resp);
+		if (ret) {
 			__pvrdma_destroy_qp(dev, qp);
-			return -EINVAL;
+			return ret;
 		}
 	}
 
-- 
2.43.0


