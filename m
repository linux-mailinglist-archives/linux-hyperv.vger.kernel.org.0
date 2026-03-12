Return-Path: <linux-hyperv+bounces-9366-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLXnJIYJs2kMRwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9366-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 19:44:22 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ECE2773F3
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 19:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 110F93010D9C
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C063FF893;
	Thu, 12 Mar 2026 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="feYamPbL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020115.outbound.protection.outlook.com [52.101.85.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8063859FA;
	Thu, 12 Mar 2026 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341000; cv=fail; b=aecH/pavzZS+wLpLLG5WvpdmC0MwBeRamE6CZ1ILPawO2ZQ1eCpvHHkc/z7Atubs/M0ELbMi5fwhQkPpZ6+KpuIy8JHe+vii357BXL4S1cGVo+1g1T1EsCkWUeCHg1hFO5iuOUoLfQ4VDNJ7QiHb9SKuAHNyJ7saEbhLvwg/xkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341000; c=relaxed/simple;
	bh=fj8gMEMS55dp7Jm+bt5wZmBpKTqg9/Fb6prnB0dHcCc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CsJx0HRwPbIdiC22lW1IFptaiKaWxNIRFS8Emdl6FXDLy7DSB5aAEl8Xdnc3NtHdOmXBQj7y/NvxgRU+1UBZPFC9jZoON//mFssY+frPI5iHWg/MXXliu5zrNUE3H3bV3JVGTbfeleOhWVa5Hz1mcd6i1cWWZ4rtiI+NSPS1zSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=feYamPbL; arc=fail smtp.client-ip=52.101.85.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiCbNhMF5gKui7e5925synoxQAig2L/o/XaszIaqxaVmBPjacWQExk/3YTQ4AbJFKLLHgv/tcKxd4+GaRCU2BfDLJIyHrj7mWhkvqVweJOmxLImLLCAAQc+n5XX46/JuL7rk84Cm8lc5qlwTIQRYPryYtzX7NryEyybYhuOwS6m6qroFdXAxHk9kHWM7esR/Pttzdrx7HIrONCt4eDid170M1jv5CxOhuqwHlTUmz8RI7R0rsM46ngnO0C84u1YU73dIsjjDu16+1HZjYvOHOCI0lwfW3I0Z+vx0MTFQmF+W6Kn+GdWbn/C8UwU7a+Jn5C6ZE62zOdK8yRVZPl2lXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RccHb/BwciZ36vEaDH8FUUPQSjmBfUJFiDnZt6G1aqM=;
 b=D/xf/CHESYYJBtIcVlvad3vx0KQKBxxHaWtGVtnZHg7WT2O7/6h3VBjZC7elP1Qm/QVLYu0BT9AKcNHBvcLRmingr3Fc1STifeWF/oUFOqjApmFGtZZVxT26lQmT4qoJ4c+7b0ZKknDpjeJk5nIEDwHO59L6e1Cxk0bdOBmMFuumqyDDIePRhZK5RrxS5w/P88lRCwiQ1tszUk+LdH5BJJbdxhtCJH6Hodg8u+MHW/n5lrcIA0Vibs2CJ854OZycoa2qq7JqJIwEvdiSMqOSlwd1rx9SMzTpwlZCgqjhSuouZCNMUamGbs3JUY81TzZX1z91nEWqz3shFdxJKGTJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RccHb/BwciZ36vEaDH8FUUPQSjmBfUJFiDnZt6G1aqM=;
 b=feYamPbLlMUHhKkAac1TMOez2JMpKrdHcgoQ8ImMeBrvLxyKtd2qzRXs7AWQcNqAcrAkD2ZDa90bWXaxbWL4MgY/cEwfq6pfNd8Ftjxlb/UqewdUbgSG7gLkXJKYp+gNIKnVAL7Ce2fI08cxkJmfNdSEpgGo5AC66mmHwfO2LY4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS4PR21MB6022.namprd21.prod.outlook.com (2603:10b6:8:307::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Thu, 12 Mar
 2026 18:43:22 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 18:43:20 +0000
From: Long Li <longli@microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2] RDMA/mana_ib: hardening: Clamp adapter
 capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Topic: [PATCH rdma-next v2] RDMA/mana_ib: hardening: Clamp adapter
 capability values from MANA_IB_GET_ADAPTER_CAP
Thread-Index: AQHcskxp/rldcz8WSE6y5yrJ7Ov/rrWrO3yw
Date: Thu, 12 Mar 2026 18:43:20 +0000
Message-ID:
 <SA1PR21MB66830A5FDFB26CC2AE2BF35FCE44A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
In-Reply-To: <20260312181642.989735-1-ernis@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ccafd27a-6ab9-41de-a2e2-236fc84744b9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-12T18:42:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS4PR21MB6022:EE_
x-ms-office365-filtering-correlation-id: a8b8ab4d-d405-4697-cc5f-08de80673b82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 AyUxWB23hAxqyfF4bH3QbgJA0tvB2dW+sA0W3Huq4EFsOG3SUgh0SD8OpOxQgSpkpxJqS590GiNY/gJL22qOie28A51x4wbK5QJ6C4KiXj+o034xgaeNSYSK+HdQfcjsh5KOMiUHTh8EBUL2hNTwApwEQ1ATwxUyTHyWrdNcwgjeTrF+sgFoEYwZYyTsOlXJmuS3NkldqBWJndcnHTQ+NimRg41YTyGklpxzx3fSPjr7zIwRUHbbZQEMbuaEzzDSxLezwP30rWmGwKz8KGeOEJLfUVEngaBuiSgCs99WhHZkhTdL78JVz7KL5NFlynnPEFN+x0tGQsIZZdywlox+rsat3UNm3/TpSU9FB93ykzR56aB8w6mF693xyzcqWknpeZx5a0O8a4hLfaP2+oCumgdotUX0MYzL5mGXDWK9DjcPZ5VcCG/Pcd3B/scAwn5b7Cr3HiIhLyD+/qc/qscJ8VQZ4VVTCTndkoxHq1gElZijpPupmgyiVDoHUptdENfC49i/D6awWvzhjHo7L5GfwmwrQtuSmIMREIoFcTUHsLbysV7kjkpc6ce+MZIE5G5+O1YJCIh8djcgpzuJ1HNsCuEMRn+PwMW42MFx84q6ZA2QX0xnfD/7El21ObnlCJe4ss4SN2XVXGYnaHp98sptqi8NyJjEwqQOG4iRNh/us+7uSkxxHJKz/bwmvxCvtd6JSN9mV6JH1Am8wIa1PMfl/Ycf6b4UOZiT485aHq6sJQ7tSY0l43y2RItQnQ8kZB9+WAEeqK0tSKhoDS4vswzJag4g1TfATRfBJ2LLHYEnTJY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0MkiuKuKxNFae5ta5UpnXBp1jDsAME71Cr00uAtS00DIKhdBDljTUZMP48Hh?=
 =?us-ascii?Q?87xoZVbal7jBlJbe5y5l9GE+x0UPfFpg6PWB2U2bAkG2pn24TYB+1Wva1vrZ?=
 =?us-ascii?Q?HkN8w0xUPgzIf3dEfykR8l7ltaKwTLswtB9R6slSqaJXKzU7FDKYQKGWxGXW?=
 =?us-ascii?Q?aFRHJe58GpdwepN+et3k/qTD2fiPZM+dyfigFjF9+wQXkYUNupk3xA1ia0Kf?=
 =?us-ascii?Q?AE2F/1I7Uwt/pNHkZS3JnLoU/QPIgJzUFByzq+ZioVkqGRgjH0Q/pClUG6Tp?=
 =?us-ascii?Q?RdICtduzS6Le9W6gcmrOe2AFr1wOW9sblAMubtoAxK8aAf9ty6wp1YqMJ8+d?=
 =?us-ascii?Q?NPvR1fbG/4a86ptTXr/Sc1jz21xW6AOisLhyJXm3MNxUJDVJqcwSxq3qqVCH?=
 =?us-ascii?Q?ITMexWaat3i1SU80Cyb9QMmFnV+ZGzWpH0Owpgqhe59UlPlXbfBlIBzx4Lbb?=
 =?us-ascii?Q?B9W1ldDyIQfqaqQL/KWe96F8tPJyAqvBadVoj3aKFHiLH42iC1AhfidoGhP/?=
 =?us-ascii?Q?FssGhr+R8gksSqn4iVR3qxMmAv5GedB0XVpfWDUHYjZbc4kmNGlwdvN6chy/?=
 =?us-ascii?Q?WXiUWDBEn59T3xD4mpKOqwaV/ZrCf88GEb83JQHfplGeXQA0v8ol3Hh0JcJe?=
 =?us-ascii?Q?5zHbrgK/xd81Qn8wua9wmhaStgxFMGd/djPzGGCkKGiqilxBrd0bqpJr3KVF?=
 =?us-ascii?Q?ccnIALB8clq4Xl14XrzvVZB6FLmABawm4gFbe0Vg5UaRbDarmN6HAaheDdLA?=
 =?us-ascii?Q?vtPLbGtbGO4YCBI1cZBANpuaOqE6lVlx7cPABWAEiZaD7hYCAYm+1rbfeezw?=
 =?us-ascii?Q?WF4R/rDKhj6QFpppWt/cXneWluz0/D98XPy4SaU+Eannz1IjGWT5EKwILIFF?=
 =?us-ascii?Q?z4Dxs5ffjI53KekRUSpzWyHBkE6WjQDbvtnL1i66SnNMLqf8NSQFy42vJlYC?=
 =?us-ascii?Q?GZ2DwKQSUanitVLn7nSo4M6q1UdAveJBGKucYE/2c+sWQma3UJk9RnE6EIEw?=
 =?us-ascii?Q?x/0NkfxE+665PtIPrZLMtZqUAmZiCLBYzzRcQ9vWWMrMcbLmj5MIrq6sESdK?=
 =?us-ascii?Q?WKP5qnlUYxpuuid0316+2sOnZRmxglNgYKH3lgCsTmyJi3QCn4KEaw2FpFug?=
 =?us-ascii?Q?GAs4ZsxnU9bWkmPR8+W2nSXyzeeW6fAn0Zm/Txt6nOaraBTnpUXeod882Xr+?=
 =?us-ascii?Q?CqhUuepbhOVFk8pcVFlxidR44Lpa3LERduj4cweQTqtXbdstsIildYCtuTCA?=
 =?us-ascii?Q?G0NQhkwUf5IajsFpOc8fbX6wgeGHkmbAkddSLXT4BXuyiedNYHKi+oivCU1O?=
 =?us-ascii?Q?yiRD6I2h8KY+qnskK0VtBEVmLUyM1oB3xshbVUi4UsG40wXm/TaHw0TqM8AM?=
 =?us-ascii?Q?WWeFtf51uFREVNhqQClkzVWBgoX4/73KMpFq1m/6ML5ezyqdcnRhHX3O3ml9?=
 =?us-ascii?Q?IwWAiX3KLaeEwlIwz+8iO3S1j6s4k9K8b17UDDb/6BMYQJH54v0nkxWeVcE/?=
 =?us-ascii?Q?ffRxSC3kaV+Qre8XAZojdhnf2aCpR2Ip4/arXojIeUOMN/WL7MHjveo/Uxob?=
 =?us-ascii?Q?Gp4fjAqySLnS3E+CfxU0F3RvE2kVpdL62wOaJ//RTdVHwWkS0QnbDNgs3cMq?=
 =?us-ascii?Q?ojcuvanrt/dIC3GqgUtg67HEaxwF5cjfCdeNDobe+9xcF64ZcvYa8aIfE+Id?=
 =?us-ascii?Q?is73/zilrIcNmTCZfZTEsT4aiiN4Ix0dooOz5aQppeVN31jl?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b8ab4d-d405-4697-cc5f-08de80673b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 18:43:20.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGpaCtUqoCf6+BncZl9LW85fhnAed/VoLqCIs7JmOF+lItZDXjSYpB6roVEmS/PDpXRO4foiDpkZb0StiTc2xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6022
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9366-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 05ECE2773F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Subject: [PATCH rdma-next v2] RDMA/mana_ib: hardening: Clamp adapter
> capability values from MANA_IB_GET_ADAPTER_CAP
>=20
> As part of MANA hardening for CVM, clamp hardware-reported adapter capabi=
lity
> values from the MANA_IB_GET_ADAPTER_CAP response before they are used by
> the IB subsystem.
>=20
> The response fields (max_qp_count, max_cq_count, max_mr_count,
> max_pd_count, max_inbound_read_limit, max_outbound_read_limit,
> max_qp_wr, max_send_sge_count, max_recv_sge_count) are u32 but are
> assigned to signed int members in struct ib_device_attr. If hardware retu=
rns a
> value exceeding INT_MAX, the implicit u32-to-int conversion produces a ne=
gative
> value, which can cause incorrect behavior in the IB core and userspace
> applications.
>=20
> Clamp these fields to INT_MAX in mana_ib_gd_query_adapter_caps() so all
> downstream consumers receive safe values.
>=20
> Additionally, fix an integer overflow in mana_ib_query_device() where
> max_res_rd_atom is computed as max_qp_rd_atom * max_qp. Both operands
> are int and the multiplication can overflow. Widen to s64 before multiply=
ing and
> clamp the result to INT_MAX.
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> Changes in v2:
> * Update patch title.
> ---
>  drivers/infiniband/hw/mana/main.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 8d99cd00f002..2869660077ef 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -599,7 +599,8 @@ int mana_ib_query_device(struct ib_device *ibdev, str=
uct
> ib_device_attr *props,
>  	props->max_mr =3D dev->adapter_caps.max_mr_count;
>  	props->max_pd =3D dev->adapter_caps.max_pd_count;
>  	props->max_qp_rd_atom =3D dev->adapter_caps.max_inbound_read_limit;
> -	props->max_res_rd_atom =3D props->max_qp_rd_atom * props->max_qp;
> +	props->max_res_rd_atom =3D
> +		min_t(s64, (s64)props->max_qp_rd_atom * props->max_qp,
> INT_MAX);
>  	props->max_qp_init_rd_atom =3D dev-
> >adapter_caps.max_outbound_read_limit;
>  	props->atomic_cap =3D IB_ATOMIC_NONE;
>  	props->masked_atomic_cap =3D IB_ATOMIC_NONE; @@ -694,20 +695,22
> @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
>  	caps->max_sq_id =3D resp.max_sq_id;
>  	caps->max_rq_id =3D resp.max_rq_id;
>  	caps->max_cq_id =3D resp.max_cq_id;
> -	caps->max_qp_count =3D resp.max_qp_count;
> -	caps->max_cq_count =3D resp.max_cq_count;
> -	caps->max_mr_count =3D resp.max_mr_count;
> -	caps->max_pd_count =3D resp.max_pd_count;
> -	caps->max_inbound_read_limit =3D resp.max_inbound_read_limit;
> -	caps->max_outbound_read_limit =3D resp.max_outbound_read_limit;
> +	caps->max_qp_count =3D min_t(u32, resp.max_qp_count, INT_MAX);
> +	caps->max_cq_count =3D min_t(u32, resp.max_cq_count, INT_MAX);
> +	caps->max_mr_count =3D min_t(u32, resp.max_mr_count, INT_MAX);
> +	caps->max_pd_count =3D min_t(u32, resp.max_pd_count, INT_MAX);
> +	caps->max_inbound_read_limit =3D min_t(u32,
> resp.max_inbound_read_limit,
> +					     INT_MAX);
> +	caps->max_outbound_read_limit =3D min_t(u32,
> resp.max_outbound_read_limit,
> +					      INT_MAX);
>  	caps->mw_count =3D resp.mw_count;
>  	caps->max_srq_count =3D resp.max_srq_count;
>  	caps->max_qp_wr =3D min_t(u32,
>  				resp.max_requester_sq_size /
> GDMA_MAX_SQE_SIZE,
>  				resp.max_requester_rq_size /
> GDMA_MAX_RQE_SIZE);
>  	caps->max_inline_data_size =3D resp.max_inline_data_size;
> -	caps->max_send_sge_count =3D resp.max_send_sge_count;
> -	caps->max_recv_sge_count =3D resp.max_recv_sge_count;
> +	caps->max_send_sge_count =3D min_t(u32, resp.max_send_sge_count,
> INT_MAX);
> +	caps->max_recv_sge_count =3D min_t(u32, resp.max_recv_sge_count,
> +INT_MAX);
>  	caps->feature_flags =3D resp.feature_flags;
>=20
>  	caps->page_size_cap =3D PAGE_SZ_BM;
> --
> 2.34.1


