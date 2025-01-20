Return-Path: <linux-hyperv+bounces-3737-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D49A174FA
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Jan 2025 00:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B54418878C7
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15151AF0DC;
	Mon, 20 Jan 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NZ4HCLyZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020100.outbound.protection.outlook.com [52.101.46.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57844192D70;
	Mon, 20 Jan 2025 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737415256; cv=fail; b=g/5zDtFalYcR/B0dJdRnWL8UPxMC8SMSCfyqZw5KAmy+3G9UM48KnipquCagDu76xBoLXkZsIe1LMHhCxP/5DFA2O4TU7oXBXPHgrk8dms5sut0DRCrFScxqHubkKD1qDkbCm30CFKD9JhSH++hSjqd/TYOrI2RaFPFZby9vkII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737415256; c=relaxed/simple;
	bh=ZfITZwkkh5cG307dKA/0JnAoKhay++VqNg+CnC0zjdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r2Jb8q//WV6J2H6PVh3dEO3oVP10805atfRIgpl12QmVUV8R3yU3FvR9o0oDnE/WBd2ZGE5dXjcvJianM1vWTgKDekZy3LwHF7valu0643k8VUrFSPXxHfBHYixLDccjolf8d8S0oOmxehlt+0KRjEwvz5UGdRd4peqUSeGr5wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NZ4HCLyZ; arc=fail smtp.client-ip=52.101.46.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMvzYpNFjaDXQxJ67EKRmZTEHraTkTuTyWWhZyGJOjNs5B6k3KgZLbgyQQncOajInKpg652O5pozk4vXtkClqR5amY9Gv4qdW85tx921iPL7uW0Udj6M75d2hwbyme1viTIR7GhBd9/C69thW451urvA76fqZsGsfzPix5wTkUi8pHAgGuMQQdY169fEN7rnzIMvEmc8oqXCUkh84JCecVFyvTb0U4TsPfvgoRJwPg6SMPIjxGcaIFS6lReeLLcQNoGSQpNA+1CJ0iV0bqEUQso2+/P1U0lAiifFPjkv0BEhKgI/Ro/xhM0U1STlPq8yS9McCZrduz/3+td363ZuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaAA2or4ZIv5he6fl2G6R/UpSVgI2+NA4yGbhACGJCE=;
 b=AGTbHV3uyrv25SE8I9koD6HvrrO1mHvhwef+F1QTakPLQDlaTGLo9T109Q+OeI9nkET8krGCDCVmmoU6Igig3B0drdtC9hRxvWBw67SRZw8OufyN0ja5+qinxmDvxKbcboKVVQNtBUhmM60kMtqDYkEh5Yo9IoyxCAxzr6ELKCFvC40eyepdxP3oYaPuRFcSEGb4KBPifoqdf00uxoeJOsJ1UbjX70rrJ/O1ChHm9VXEiLJ+fmkyRrN7TdZq/oLUWiUf0iAwaHzlRsTTKwYLDTZtLtX4idyZL0vDEcPLse4T5YPoH0LWX3pQOkUSV9a7pBiCfPURX9byDS4Le73Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaAA2or4ZIv5he6fl2G6R/UpSVgI2+NA4yGbhACGJCE=;
 b=NZ4HCLyZ5Ho62hZaOQkO/9yyCQKzdRFNtzTJ0nZa8R3djN2pv667E65B9WMKTpGcMLismIDLsxn0FcXnQWA4ohsHagevhbu1SNcirLhw0JD6SRv2+ao+oBNARL5c8NMy4uhdaaen5VeMnugp6EzFI0n2LLcoK9WCQpnFicuLRns=
Received: from MW4PR21MB1857.namprd21.prod.outlook.com (2603:10b6:303:74::12)
 by CH2PPF910B3338D.namprd21.prod.outlook.com (2603:10b6:61f:fc00::14e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.15; Mon, 20 Jan
 2025 23:20:52 +0000
Received: from MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::cc83:d3aa:1ee5:d6d2]) by MW4PR21MB1857.namprd21.prod.outlook.com
 ([fe80::cc83:d3aa:1ee5:d6d2%6]) with mapi id 15.20.8377.009; Mon, 20 Jan 2025
 23:20:51 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Topic: [PATCH] scsi: storvsc: Set correct data length for sending SCSI
 command without payload
Thread-Index: AQHbagGi33dHDMlkpUquI/gnvyhfYLMgR6Zg
Date: Mon, 20 Jan 2025 23:20:51 +0000
Message-ID:
 <MW4PR21MB1857121CA82F0CE544F245BFCEE72@MW4PR21MB1857.namprd21.prod.outlook.com>
References: <1737071998-4566-1-git-send-email-longli@linuxonhyperv.com>
 <BN7PR02MB41487C2C9BA6B963758E722AD4E52@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To:
 <BN7PR02MB41487C2C9BA6B963758E722AD4E52@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=563ecf69-e157-4f2e-b3a3-9ba714c38af2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-20T22:51:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR21MB1857:EE_|CH2PPF910B3338D:EE_
x-ms-office365-filtering-correlation-id: 83f8f034-eb44-4069-8bc2-08dd39a914a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g5ZWviWsvS1BSJM/FfZXmAJk7sm8BYOTgc9G7AyiFLcAT294zakWni6ivcj3?=
 =?us-ascii?Q?520RHEjcUD8XErCj9bL0KXOn/MVDDWhrdWPMO9OyO5K3O+wEtOpsfvu9W56W?=
 =?us-ascii?Q?cypQWXNq1eC7OsR5reFGeGsLCAcqJuy9Uo8EvhgCcSIMl6NF3DPYMmuPCJDu?=
 =?us-ascii?Q?cJV2KGDquVI/mYxmt9T37ihibQYDWiw0yGcUMQ6zSoAApj1I7zU5/zJhM3bL?=
 =?us-ascii?Q?vySPfF7hLcVtLUU4ALLZQPDc/X2db+NsuqyyuNJGK7xFFg1R5XXvSle9xIT4?=
 =?us-ascii?Q?zinkT2+/Z+8Og1hCKe0EijegYOu/wkPPii1EiQrEPyPlOWjTVICX08Gt3mu1?=
 =?us-ascii?Q?ETf0YC8Q32srqC543E1ChgTasZh9C5a3nzGQTELhIfkaLufPWA3Mt8Ey0wCr?=
 =?us-ascii?Q?B8txyJb3yTJeEOPixYfU/cUHfDlmW4eHWe1Zqd21QwuAPyZArnoTJBkLTQbn?=
 =?us-ascii?Q?9Uhq5qJ56lgYa1XqMM89F0DtEMfM6cS2eT0GYTCUaHjJs9xmh+owqhRiytr9?=
 =?us-ascii?Q?PZlIoxUl84vL1BTqNJ+Hsd5fxolXzI1LD/d6lr1r6E6/0+qlI26hItF4cooG?=
 =?us-ascii?Q?AMSZxuSzHa6+anYwUY0YxJUQrEDxsFm8eHW/Hld/BA5eHOJvTDKrsXnApf1Z?=
 =?us-ascii?Q?BRmJtWyXKpfRZ5qtN1sto1BCjhPTYlmTBmXx4bbJDACSKr4f45myAdbXJ0Qd?=
 =?us-ascii?Q?kxMrT/ZPlpBVRzBavmtCZlYRnuxQxA14QoLyN6xwgeGjm7n8l1+mkkxQOXY6?=
 =?us-ascii?Q?Yp4+htMyEHgErL2j09umwFJ6HCRZvIlSr4pj+1bYhXW7O1veguaWdOr74ji1?=
 =?us-ascii?Q?WSpjg0sg9nhABTy7mIayEM0xKBwskqIMsV/Vc2iaykpM1/I/nfwLLb91PdFp?=
 =?us-ascii?Q?qOKrOrB67Btr7Br9/3vuk3DIEehV3IOBcdkfEbySwmDTM8wfd98vY3arh++o?=
 =?us-ascii?Q?y89mzjDoMy3ATiX63fJ2SCzRZJyv3yNiw9GAq1Uuwe3JHGnlbnGYY3oiJJw7?=
 =?us-ascii?Q?RUstfxKATeEQNeKv3esPnQAmBXcv2o3Y3wTxmxdHzbuOV9gSZZ4Nlj7fVrGK?=
 =?us-ascii?Q?2f0MPtXBl1B1gTilC0cwWLP/sbQFA/7o6Yof2LZUxJ0GnFIXQ+3Fm0YRmOPF?=
 =?us-ascii?Q?9XYO30KWYob7HhxNCtT7ozPPGVL1QokwSckbLtx6wvfqZlX4vbTYaDdy9Y+/?=
 =?us-ascii?Q?RQqcjj8SEFimJOxvsneVc+ZZJhoYdKVrtOzYBDjgpXeo4kC3t2eta6rl1FFl?=
 =?us-ascii?Q?EcMRcgAhL8rm0/5P11KNXocsJvblA65f4mgFr/ijji9yqAB1xmPZkwq111iK?=
 =?us-ascii?Q?68FFbE6gMOoo/SJf09GTGPwEPmhtJW4LoMAW1BfPE57S50vAPULzbNLKvG/p?=
 =?us-ascii?Q?dPRm/WFna9n3Xi3yRyzRkqA8i2WucnW87K3BQkB/rmV9a5q7gyhotd/yD5tA?=
 =?us-ascii?Q?m3vEawwXQMUWS+exGBFlfrSzhtDgrPHMQwsjtT1TiGt9eZDpL3Jrsw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB1857.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0UhQSSKNYOypMyyUCcW+TW2/VkhSg/dAGbxTud4PKb+igAKSUzWnHObb0vq9?=
 =?us-ascii?Q?wiFqhYe3BFJUzzevXw1KS/Fe0Qzqp8dIjeiQgEP0GvQV4ztQZ1flJ00MTPeN?=
 =?us-ascii?Q?nNldKAMVlmAsUCAcePlxYT1zF6T75SytPMjftwDZi2toA/I0YjYZr3kb7+7a?=
 =?us-ascii?Q?DOcfYcM0ohVgzu0tLwdLO0Vqd6wtO913Pinrbhx/rKy6wjko4thqRkf6XHbR?=
 =?us-ascii?Q?IE0zlSpU0ROGLLdcCgD+/fnzd8FOo1RnKQmuh1JCVJF3sNmYRM0vE7Un4LUG?=
 =?us-ascii?Q?A5WKL+70rftKao02KQshiVrvJsb+xJWx6gKufKNAfjEqW45AtENwq37G70qX?=
 =?us-ascii?Q?GfqXiouPB3f05fGbSVhdl+yhlnfXFg7bNBfeMO6bZ4mnrz3Vnj9DzWmnJT2j?=
 =?us-ascii?Q?kLvRZ67yGoVKuGpgOEvoxG5xRs/sqzLEK9O6z/5wgoefBgmv5yozR1keaAum?=
 =?us-ascii?Q?VTWGoBfffYrA0qWz0r7J8McZ5uEfwPlsm1lkVR1YqXKTyswlytsukadI1Cwb?=
 =?us-ascii?Q?hL2eZ/3bak8hwlibAe62EiS+dqGNU9ga9tUhPMuGDM/8qQFBVqjl2vAcIAN3?=
 =?us-ascii?Q?fq/IRJoqN8izUNMZzJC4WHN5EjChMLS2gS6My2d881EZVXRWXENmNIo91y28?=
 =?us-ascii?Q?w/io54UpsnpnWnvcwAggyBG7c5XWvBCCqSzr0QQj2DmsJgGzt3ooneIZCNUQ?=
 =?us-ascii?Q?1DTlMONp2W1IUIZcnI3s83mPoizS4PoOEh+65FwWv0ZpVisk5bqNNKjHmRVU?=
 =?us-ascii?Q?6SuebT1dUebD9ro8kgs5YT8/z2PK3bMu2Uy/D3Z3Ql9fvNMxj1WZAVaaxd1d?=
 =?us-ascii?Q?QP2owjlxfIXXXox6em3Wu7u62klYrWySbAFGb29R7DNW/4EPM15swjyLdE/d?=
 =?us-ascii?Q?80N8jo3DGChFCeEkBtF4KoP30SH1oL6dT5vURK30RUqg4aKJlFw1rvf2mqMt?=
 =?us-ascii?Q?qUKPeZjQj234GmwTCQiG0QCqnLgrncB7rVFXXYYq5t636MzY1Tttn+TJEeOH?=
 =?us-ascii?Q?RojB8o0/+EXfubsNzVo0OODRl+WR1qWAwZM6XTmS9+nh/lAmBbvLGG4HiCpw?=
 =?us-ascii?Q?BQ/Bb9y017h04+RYqKbeb3ktS5Wn3GarzNAaOjb8jn2D62f+FhONqiEdp0gk?=
 =?us-ascii?Q?WFO3bxMiOpY8X6oy2USZbN6a6tAW3nu2/NYGKbAs68zp7KMn54JZrJspMxD/?=
 =?us-ascii?Q?/oW7xcvYgxuMxqoxGricVQSnrnuYTa+34GIARd+/Cedg4+y3hMJKoP6Er4hH?=
 =?us-ascii?Q?HSIfE8Omj0JwawbJOxfM9UgPaDpiv8OCCgVqNzlFclE/yJ7O9owlOc++Kiyd?=
 =?us-ascii?Q?7xE4kXfBSPg7vCgykWD5NPrn9thh2+/9tY07QtntKRDDQOUooYwXZ8iIy7z4?=
 =?us-ascii?Q?25AhPcLaQL3Ex0gBPKZhBPwBJbDUeiTJVB6fC2RrjBr/o7dMuNs8b3cPYDho?=
 =?us-ascii?Q?OYyzE25Ts17sOdux/mPeh9BVg3PtSuUHp6eGm7lY9XaNeYO8mjJF7js05/ad?=
 =?us-ascii?Q?hYEuuZ5iYhIXebsYTHGv/7Cd+e94dNkVgAVHnwVgZGJgjD0QF3NQwhC8YgWR?=
 =?us-ascii?Q?12t1K6389lfLJNBMY9Rjn3DBEogdjP+/kh2vs0D1c85GJtPu/7GZVLeicFrT?=
 =?us-ascii?Q?cQ3+FEol0aiVAQc7eJfF/z+3V0Udj6VIFcunNYGnOHG6?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB1857.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f8f034-eb44-4069-8bc2-08dd39a914a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 23:20:51.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +qHXv8W6WoeTvMbmf214405StHRwjDqeF0c7RshyQo7gYaof9uafYu/ACh8Zt8rsqp4YzC6p93BdkrJbp9U68A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PPF910B3338D

> > In StorVSC, payload->range.len is used to indicate if this SCSI
> > command carries payload. This data is allocated as part of the private
> > driver data by the upper layer and may get passed to lower driver
> uninitialized.
>=20
> I had always thought the private driver data *is* initialized to zero by =
the
> upper layer. Indeed, scsi_queue_rq() calls scsi_prepare_cmd(), which zero=
s the
> private driver data as long as the driver does not specify a custom funct=
ion to
> do the initialization (and storvsc does not).  So I'm curious -- what's t=
he
> execution path where this initialization doesn't happen?
>=20
> Michael

SCSI mid layer may send commands to lower driver without initializing priva=
te data.=20
For example, scsi_send_eh_cmnd() may send TEST_UNIT_READY and REQUEST_SENSE=
 to lower layer driver without initializing private data.

I don't know if there are other places doing similar things outside scsi_er=
ror.c, but storvsc is already calling memset() on its private data:
(in storvsc_queuecommand)
memset(&cmd_request->vstor_packet, 0, sizeof(struct vstor_packet));

The assumption is that private data is not guaranteed to be 0.

Long

