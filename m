Return-Path: <linux-hyperv+bounces-9500-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDv0MzeauWn5KwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9500-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:15:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D67E82B0C06
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 19:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 674993068B91
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503293F6613;
	Tue, 17 Mar 2026 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y60VqY3V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023142.outbound.protection.outlook.com [40.93.196.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4837F8D3;
	Tue, 17 Mar 2026 18:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770648; cv=fail; b=qC23pEXAPiNd4mkiyC9ob2KVyhNiwZuDsMFywFNUkJ3R1nsXAxW5t5fddUWcEccjrQhjhf5oFGnOlXt25bfYbilDFua0rAVkew9ZZZCU135HHVPW8Npwyj/GZru565PDaSgdWhW8i+mUtOvmH0yCJJsopdBoam//J8jhvcS4bg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770648; c=relaxed/simple;
	bh=0uvMB7dC+6mYjZPPR6YPDNRGRFSnl9GG1LKzwGMb7IQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gxZPWJqZRgg1/tczWkGGyo8HBfEWrOa6l9PQE1qcgUFD0RQXDelxBTKwbV6oyvq7cY1pVVY5pUStOLo4UATyMIGndiijKknNEgLbBtMW8iAKL/QAMUB4phRpDYM4FWanN8b6pf3M4HaKXZ7J+ID4mFx+HSECgFzp+4DCIP6tqG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Y60VqY3V; arc=fail smtp.client-ip=40.93.196.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6r1m6ixJiFAW9zvZLtIwD9RhABFgVs7GwhI8cAhHZdZw4gH90ioytorropVV3m74T1bFHMolzBJS1Cr22RlIX1D3w1LZj0A/L9qSsF7c+8N4QIX2KbezQjZCSGCbdiTUzt7UFvca87NEoJia/h4aPb7wrZrfwJSDfcZr3PYm63JJCc3YJ9OyZBsggGn4QUGyIeG9ANKg0c3z4lYWyuEZ4ELCZ93EnfxJCJVzasttwuM7WPsjd2eQ6WtNXLf/iwyEW5qjj2gObNaqjaREQbYx4ZnIy0C/SvzJ5SeP9RGrs5hSHVNLb8sV57T89sys/tFkQZ7mi1sxSlMq0AkB1aPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unxltpV+XyrqxvnnF8y/RumqqzYW4aodE2AV/mWga5g=;
 b=R+/4+bsN2J+ZXCDg06n5LaHmcIvSPou4y4zCxH0awsWcqVMrtYXa5zT7MQfPJHwJnIbLRFLX1tZeqZgRyi33j1V04suu2BJXQLHbr3rL/aJuS0j03bUlGMKgCdexecNMpDR8V2xE4gYNUsdPoGSa65SE9nDZwpXcawUXNxC+c2O2ap90UV9ELEul4beqRKToPJre9ppvRaf3HqTebPATYOqVWWNutBen80HA7bjuXd0eD47DZH/E8lL9k5Chhv6S/EcEd/rF+n6kzGB8nrGr483bqet1hpsc99bEp14dX/c6xna2kG1LMxJYqvwFPO+JoWX2L0+0Xdw0olI1UWA3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unxltpV+XyrqxvnnF8y/RumqqzYW4aodE2AV/mWga5g=;
 b=Y60VqY3VL1cHpfUlRHLsH6K9VdFOR2r9HiVxSg6VEqzgWq5snlfHkgXthz0pEdbccefmNAqJMYtkOfX/cwhce5e7joScaN/OsWXSaeAdyH4ZsokRT/PZcPSNkPoyLWbJVRcXiDipiAdLPdrEoyO4IJD25vr7ko7JhwFF7vI0er4=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5864.namprd21.prod.outlook.com (2603:10b6:806:496::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 18:04:02 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.008; Tue, 17 Mar 2026
 18:03:57 +0000
From: Long Li <longli@microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bernard
 Metzler <bernard.metzler@linux.dev>, Bryan Tan <bryan-bt.tan@broadcom.com>,
	Cheng Xu <chengyou@linux.alibaba.com>, Gal Pressman <gal.pressman@linux.dev>,
	Junxian Huang <huangjunxian6@hisilicon.com>, Kai Shen
	<kaishen@linux.alibaba.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>, Leon Romanovsky
	<leon@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Michal Kalderon <mkalderon@marvell.com>,
	Michael Margolin <mrgolin@amazon.com>, Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>, Selvin Xavier
	<selvin.xavier@broadcom.com>, Yossi Leybovich <sleybo@amazon.com>, Chengchang
 Tang <tangchengchang@huawei.com>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
CC: "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [EXTERNAL] [PATCH 02/16] RDMA: Consolidate patterns with
 offsetof() to ib_copy_validate_udata_in()
Thread-Topic: [EXTERNAL] [PATCH 02/16] RDMA: Consolidate patterns with
 offsetof() to ib_copy_validate_udata_in()
Thread-Index: AQHcsbacjqMhlcJJu0KodvHfS52V5bWzDUBw
Date: Tue, 17 Mar 2026 18:03:57 +0000
Message-ID:
 <SA1PR21MB66834C27F2279FE50899D087CE41A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <0-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
 <2-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
In-Reply-To: <2-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2a8b0f2b-0304-46de-96f0-90b4bd1cbda6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-17T18:03:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5864:EE_
x-ms-office365-filtering-correlation-id: 473bffe0-3ae3-436c-3daa-08de844f8f15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info:
 aXNBYk+aCmXHA1dKeyAXzpxQtW1SxWKngfdbooXTEMtCwPzevKDxyHgQDg8p1e00cyY1gNjw3tcUiwCfhsUnNsnhwrhysGzfGsBtGILH9yhY3uPxPWcpNNYCMkXy/Ag1JoCwq3sid583bmzvJUQBWejAPgxauiCHrgcfbPFvgKucGvcJzZKQxP0SeHQ3ggKnPkNtuQPnJPsl6S35E04UgU9grOaMHdb5Rfvr2epeI4UXFpk4N2gNCDVmdexY2qIBw5N9CXUgbQ4EDGtzyzyuWabw0hJ3T6LvBNRoft4vbtNL5Ks+6N2jt6aNx71BB3hN0/VfsCjyNraTGHT8q3P5Dl92yPdrbct2yaUFX2EIGoxbuth9rpT/t+A5KJZRbhqFRqfUrogxzLrQkbxGsCb2H+Hs9gV/QlIq1rx6fv97UGoTH8n6kN/SD0xffG4xqu73L7LkJKvZCMknTBXA2ML+M1kP5rTQSd0Vj0Mw1WTupcgAUkqEdchZyoTHPifceNIo71xVjnz1RgQcF+gA3uBts4b+ZCMeS+ikupoehAkpwqPAWgDgvJRqCt9uJ/kafhOwslD+TxT9xMf/Bgf6ZtJJ15wkD/UN2sbGeK/OjRddQHsKG2ypLRUJG4A18Jmw9BFvyaoh/UYhLR+KS47ibScsMAeZcwX5wk2ZrLbQsA02F9pHuyAB2PSnTIQU0Bp8gJb/uH4YvSQE+RZ9AgErNGcEhP2sJgnwqfClQ/THJGfcc9JDH2L/zqTR9neAYXvSJM6c4htCGuCRAHrCH6QoS7silav0B0PigpDwCtpeSjJmVBQ8j0qKHrADzqeu6l8dx+lj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XdUMOEqfAmfVcSSr/7U0jZVgt1E0F/EKjfCag1PaVNwSSJ1poC5Almf7qKzI?=
 =?us-ascii?Q?LEWr4w8N5anRXQJXfH4UtNRre2oPJMO5OmZ0qN2tAKdZzhylc42XZWfTCiSI?=
 =?us-ascii?Q?TVtURX+Cc8pFjky3XKCOGVYRsAhQ92ofrf/3Nly6wa7nMheXdDlNMHgvkc5p?=
 =?us-ascii?Q?EAa4n/tkTuU0P8DTvHEisPqtXGrGGY5LtYavi+DQ7q3VysBSPQnIIUObxZ7V?=
 =?us-ascii?Q?rwjSkuC8rCYFCFwYMGRefKBIKiPiVXpyjYmsVDgSvbXb0shtGB7vqo8bx1gS?=
 =?us-ascii?Q?19o7TuG3s7qjMxc3pDJwBri00M7RWQRssJEg4acYuESZnITcvH2ZO9tVJeya?=
 =?us-ascii?Q?4YDcZTttqp6SR2ExG0mIKB4YJJggSjLKBBGNj7j7ayCHHk+dI3RudY8N5s6t?=
 =?us-ascii?Q?qg8IihmgtRF74ItHx7TH81BzZg+PhOyF8dWv0W+O5MwQcVIfX5DcR5Dkbk6o?=
 =?us-ascii?Q?zEyhlPOIVklxZYGOyQJa8EXTeYzUsKD9tMqdEQf+Tw5Jo5sj49T94BClqrir?=
 =?us-ascii?Q?0aLndQfmPzXDtfG/rJSfoWXFCwxPJxEQ4/zPOibp4WgAwl7hlAuINVXwsWHx?=
 =?us-ascii?Q?B9yut6YoZMSRL1wsRCE0AY6VQAPT3+HZSFofgqPqoAq/Bb1PsB56lcs3xqwp?=
 =?us-ascii?Q?hiObV//mW/MMLqpnvULTgdcjjtUoY9axIwqJCZhkILnCTxSJyGW59xrktlCQ?=
 =?us-ascii?Q?Mm7qVsCItUC4nBrGPxCxtTxubqYB1hIJFudtgMVRfiZ7MMWWxazhcXyrMsOT?=
 =?us-ascii?Q?9XVL9aB+tN1XcjOXIh2u/Ez7gQoiaimHCoLE07QXpFMiEG9JdWl5l1aOaxyI?=
 =?us-ascii?Q?qLqEjy4TYHVS+vsj3WqQa/7sXB42ZSnmcowoSN+bruEtWc3gl13oSu996wr0?=
 =?us-ascii?Q?MSSU39Xy/V1F9rK4KnTpx07m5J5FcQ/qM5go/m4Fta1/iIgSXrEgU56rlh/a?=
 =?us-ascii?Q?A9iU5TGMY+B0rd3MDurStU81/QM+nh2skKtaxX2LUeIMwp5hVDYNW/fEIr2s?=
 =?us-ascii?Q?gYOFdtVj/T8Ykj6StvUaV+xc7il5sTkel40kG8waXFIs/66kD3JfJBP2VcJF?=
 =?us-ascii?Q?uo91LEQ8dBZv1RTvqWFHYTMTQUbl5KnuHKHGVGnJyMGzQQ6LNd3v5aMp4AtU?=
 =?us-ascii?Q?PxSgdWmNQjXGAua28IRuUEDG15Qs5ogVEwPGluLBcT70BCSj2jYZgPN1d2qg?=
 =?us-ascii?Q?wy3bm1Upc3jUkhbUwoNVXp3LwmnIJ8VqgKBbGWWyCvW/OH1FXmpTygJTQgi3?=
 =?us-ascii?Q?EEmBCdwSUJDg/zq+b0/sz3kHZZA0RGCF1ic+8CwN2WHoFEr9ct+KSf73KDOA?=
 =?us-ascii?Q?+R/F4I8WHZYMDuWCANoNb4PnfLwo9w8N6yhkgXbJGI2PrT6TUZhQkfOKJlr6?=
 =?us-ascii?Q?fV0OWDbqX2axDbIgnk766cv+mpZmi83I9eSLMjp+IFAUxx05CI/XOCuMgFD8?=
 =?us-ascii?Q?0PznxlgMd+FnwdS3Oud+4nWsBVoDwFhZGyOKSmocG7qkEccS+CaxJ8/5VCYA?=
 =?us-ascii?Q?CkoUBZdRQuqi73Gz2R3JYHGSq7BDuPIMeu/HIf0zE2S32NcwdILWCkD7kvrZ?=
 =?us-ascii?Q?2jg/imi6MnoXitR7Kct8pghG5/gPrC4cWTLwlHPd6Y3mfLvrMZdiI+0HBXEW?=
 =?us-ascii?Q?AiXzF5JxdbTl6dNpMbPCt/lQ5coRUhCGTtxbH4k5Oub4nZzjar4dkV9QupR2?=
 =?us-ascii?Q?bLFSbqcGoMttIZduY97Aq6qdIxF4+z0TSlkl2PSJJ/Vd1OYz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 473bffe0-3ae3-436c-3daa-08de844f8f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 18:03:57.0979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmujeFU2j9Ds+iV+ax3X4IxOYi3/FZ0v0nMXAEndBuqF0aZ9eUT9nEK20zg6LVPP0c5MU4tibRrdk8Qb6b0kjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5864
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9500-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,amd.com,broadcom.com,linux.dev,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,amazon.com,cisco.com,huawei.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D67E82B0C06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> Similar to the prior patch, these patterns are open coding an offsetofend=
(). The
> use of offsetof() targets the prior field as the last field in the struct=
.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c |  9 ++-------  drivers/infiniband/hw/ml=
x5/cq.c
> | 10 +++-------
>  2 files changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index b2749f971cd0af..3f932ef6e5fff6 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -27,14 +27,9 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  	is_rnic_cq =3D mana_ib_is_rnic(mdev);
>=20
>  	if (udata) {
> -		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> -			return -EINVAL;
> -
> -		err =3D ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd),
> udata->inlen));
> -		if (err) {
> -			ibdev_dbg(ibdev, "Failed to copy from udata for create
> cq, %d\n", err);
> +		err =3D ib_copy_validate_udata_in(udata, ucmd, buf_addr);
> +		if (err)
>  			return err;
> -		}
>=20
>  		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr)
> ||
>  		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) { diff --git
> a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c index
> 43a7b5ca49dcc9..643b3b7d387834 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -723,7 +723,6 @@ static int create_cq_user(struct mlx5_ib_dev *dev, st=
ruct
> ib_udata *udata,
>  	struct mlx5_ib_create_cq ucmd =3D {};
>  	unsigned long page_size;
>  	unsigned int page_offset_quantized;
> -	size_t ucmdlen;
>  	__be64 *pas;
>  	int ncont;
>  	void *cqc;
> @@ -731,12 +730,9 @@ static int create_cq_user(struct mlx5_ib_dev *dev,
> struct ib_udata *udata,
>  	struct mlx5_ib_ucontext *context =3D rdma_udata_to_drv_context(
>  		udata, struct mlx5_ib_ucontext, ibucontext);
>=20
> -	ucmdlen =3D min(udata->inlen, sizeof(ucmd));
> -	if (ucmdlen < offsetof(struct mlx5_ib_create_cq, flags))
> -		return -EINVAL;
> -
> -	if (ib_copy_from_udata(&ucmd, udata, ucmdlen))
> -		return -EFAULT;
> +	err =3D ib_copy_validate_udata_in(udata, ucmd, cqe_comp_res_format);
> +	if (err)
> +		return err;
>=20
>  	if ((ucmd.flags & ~(MLX5_IB_CREATE_CQ_FLAGS_CQE_128B_PAD |
>  			    MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX |
> --
> 2.43.0


