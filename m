Return-Path: <linux-hyperv+bounces-10061-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFhpGKGF1WnH7AcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10061-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 00:30:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9D3B5525
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Apr 2026 00:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F5C93027561
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF7381AE1;
	Tue,  7 Apr 2026 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f3IIjmpn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022098.outbound.protection.outlook.com [40.107.200.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D723815FE;
	Tue,  7 Apr 2026 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775601041; cv=fail; b=eVvOn0UogWRR76SH7zdgGgeGHy8cRbn5+pNeFw/5ESCm7GyT3VVYibS5PzNdHk7LCpzkSXV+Lx8Z/kCOAYCdzXVNOwUMoe/LcI8yPEbPjQO/kvRkv9nMa1vftVd/l9J2Dacywf0o4BQo3dfXOZxK9YEtQrvy8Nx1W0eFiLjSL50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775601041; c=relaxed/simple;
	bh=GPsLMp8rHowmDP/biDnkxGhVcv39cdycDCYMLH1JwyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QF0H/QQGalrSASgtVavqBezncrkR2YM/z0PMSf8OINvt2IE0myznvK4GpsuYmilULhEEOdBmxy3jPZzpTjqNJYoxIxB7ek8XD6U11HUiYAw2bwvQbiuYnO8+s7wRS0MS/Dig4fx8pNwSZbxVgZWD2wf9N5D5z2C1fFfVC8vAbeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=f3IIjmpn; arc=fail smtp.client-ip=40.107.200.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVp6dJ85o7wWYrMo6+zQCTdSTjeODWYamOl/03USC7hr3ewMG0Jcf2PSO0C4gqM6Ft4NZkxRoxUR8Jv2jFNs2/UyfI2SIdbNSYOPFO94rZmwMnpXguBBAJmgd+4rqtWrxIM8eyq3iCr/NHuep5RWpnzNuTdBhOuGmLdejVR0i1wb7/gJvIVXfKbEbaqGB+CcPUqaTNH58slYR0AiU+4k85oFtUUbOEvuw4DguUP+JCriWieIlWVWIT8xMR7stEChppmtHq3Pn5KOtZ1stmN0puZf9926ohCwikJ9PqIK7i2UwVv9kwC0lnxramTsgSuS+f0xph62LntIj4fHN7H57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tL44mKtDMOI6h8VJy3z2i/7lIKi6YO7ocFqSa6SEiE=;
 b=cA44rMDewC709jKLUdKjuc+HzYlLAZ4OmGoDL0nQ9gA4Z2cTBcvSft6wE3BEExx43/CmP2wY4PB8hN2IUgFXgHbSDAmr8r8v5f6lI40pGy6VlGTTdZo03+gvZgeK3Oj59nAUmBQ+5QniquWRtKTKArnX7xKJH/mcYl+dvct57ngKmJl52giLmeTIuoxQXdQq8dqktnSD1yLImPhNeEBHJyCASdTtd7eKpslAt4LZ3Kai3wg9DhPjdsmvcKwfah3drRObqG3vi53JWh9O0nvm0tBhYJ0OEhl8E0arICEpMtHO2zvWe9FVcNcpHfYhV5ylW732/+KoYWa21IC3Xa6Nuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tL44mKtDMOI6h8VJy3z2i/7lIKi6YO7ocFqSa6SEiE=;
 b=f3IIjmpnmPVsXrMOwg/Cug1NzchsIJWkBYD2rNLq7tO2Wqv16zlReh2xiA1ZxnUwEV9By+XZ/e4bgIbIT2SyjbDdZ7p7J2SG3l2W1gxT+BtTk6ZR3HuiKyfqftDtkwHKB2WdxjSHFMYxBQjwNqK7xP7HC/EU4yTXw1aVCDVmF4A=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5745.namprd21.prod.outlook.com (2603:10b6:806:498::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.7; Tue, 7 Apr
 2026 22:30:37 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9791.012; Tue, 7 Apr 2026
 22:30:36 +0000
From: Long Li <longli@microsoft.com>
To: Li Tian <litian@redhat.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] scsi: storvsc: Handle PERSISTENT_RESERVE_IN
 truncation for Hyper-V vFC
Thread-Topic: [EXTERNAL] [PATCH] scsi: storvsc: Handle PERSISTENT_RESERVE_IN
 truncation for Hyper-V vFC
Thread-Index: AQHcxWhI8ttXnTruHESVQfojh1VAHrXUMWcQ
Date: Tue, 7 Apr 2026 22:30:36 +0000
Message-ID:
 <SA1PR21MB6683ABEAC8B490387658B7C7CE5AA@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260406015344.12566-1-litian@redhat.com>
In-Reply-To: <20260406015344.12566-1-litian@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b5dbd833-e995-43eb-9eda-b36a5453e844;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-07T22:30:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5745:EE_
x-ms-office365-filtering-correlation-id: c6137615-9af0-4c19-06d5-08de94f54a59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 qIjc/CYD5svn1GiH8dBjpCEXZpQcsoE8qFbDGc5DzKv40HnvenQGtEL/hW6VG367+PviatDl4lXn2GQVm2pzmJD24LUVIqa1+FDJNKy1lf7JjhTksXrZ8PedZXTLAqy2krrDGjMaiDg9KQpuAESMvmkJbgHkJoVpjpAk1iS9UVPDp/Ooa0o0INbtxLGybvMrmSLJ2JXBRHK+IcuOcsNMRqewKOOCKEKTCj6as9Nfa8WBogqhTtEl335+sT6YS6mL7sUIW/Kk8I8KNPwiOjb3sqhJGDhT/AOWZ0LapfuTXos1s8udKJ97gUI4woC3agHrDzBpYHIIyJjwrUnOf32HlKJGDRXq8d0ALKpWD+PDTAGR+cufwSvfxBmt/vT/2HFwOw5AI7O3+JaxXxDeRYfhgFso50IAsWkboErGICWVUWejZv9M1YoMzGEyWSjG9qQJgpMkokBV8u4rIYSNL21OXJ59d1BN3R8BRSqekDOH/VWcthGNz8h4XExrn6J6m/TxlYajcGMfRM99z1qQokaiKBkp+nNUiqXcQGlaKHwct+AJIOjmkFMRqt6/DzjMd35Bg8Ll1TsAC08RkdAIfqhZPqJafSDOo2CgxwB3YhCuSq1De4ZZAwDaa0SdIw/43fLrT+DgyOBFdKFXcwdziZYzMcUO7CikKr3rMKdPWctigV9eFm/wi0OzXyjcU5gd2697QleRnSTu7vp8CdnHjyaqOdFhsG4Xcv17FV4ts4jF8ODkgWMRofMuuETOl819S2ux+9WJHdBTsGd2uzOP4r75qe4qZOSufsrUi7sU2Nm6Q40=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GjG+2LSE1acNm8nzFTu11Pe5fGUWgA0uNJno512DlYgYZWDW9ttRYtfrnU8y?=
 =?us-ascii?Q?2DRwj+inBOTLohEciXr8ycwFQJuxCT4loNF5XK0/F3/jF3lRSrw9vnkIIQru?=
 =?us-ascii?Q?bvwMbtjRfovUk8lZwhkuyVrO5VLUX30BpDRzqFq2FEVuVNhgVH8sp/n4CPS3?=
 =?us-ascii?Q?Zw0dtO9gbDNnSK7gqv0u0z+sVIzGPRoJw4iDfnQw3GWZDCWsCv9wiiMZDDbe?=
 =?us-ascii?Q?jAHU3BSRB0BpqSt9H/61V4oVJHuW0z1Bf82jfTL+dwsJ1vSzzO3Jhjerz6/Z?=
 =?us-ascii?Q?FUdGIvD4WEla2gSnFs6dYURhYdoOFh2TSeeTZtwTdVnHdAewSS4fVTRFJL+l?=
 =?us-ascii?Q?ecMiEWGmpEMNhiDQydUJYmI293b2AKGBtOM8XG0PkriOahBCenVfoMiMeuYL?=
 =?us-ascii?Q?z7fU+ssS3vgkiuNmYlhwBA3PrHjvmfAQKGZXceUBzOn5+9h2bmDdj+2Q55aR?=
 =?us-ascii?Q?R8A9B26f6UeC/GtRWDww6F5wKd9jUMQoiVeeS5q7zIlgVzDweISltxmmVf0A?=
 =?us-ascii?Q?APTP+vtofGHLmIpXAqPlFRhwYmiKtw72+9P4ckQ7gEO1ksxHNXjTWVAS+l7W?=
 =?us-ascii?Q?wZt4tWb45uWXKP/xXDJ3BI+B6CISvtKKi4htwcQuODSckCDHPuBKGqBwKna2?=
 =?us-ascii?Q?JBT+2eq3LaUyQbHOs5T0y5UGyBNZX+xpFyTVsoC5oNEOwfDE/b4CEd0RMKG7?=
 =?us-ascii?Q?Iv1S/fwwTIbxddfa1+dugvOav8TIHgln7UWSP8ITTbJwAryJhTTyS6dIxnJt?=
 =?us-ascii?Q?hbeosf00L4+FlLYlF5mcOQIHZI+AOFATem8Vn4j1b58yGEFdL4/CEYG1Wi0p?=
 =?us-ascii?Q?1Zy/G45+GhRqEhBEkUCLUYWc8EtTUw/gCh6w56xIvZ4tglpTmt+ypIwMsDNt?=
 =?us-ascii?Q?QQo77eRa+UdpZ1RxRkbXbmuDdQppO9DYy87s97fNJ4B5OY07ZbDiNVxjC66n?=
 =?us-ascii?Q?cMjR27XwqMhmf8rUkqqrLxco4xVMKp83UAyqu8DsbhbqrQ6TktCOZHYwYJbj?=
 =?us-ascii?Q?Fb+oE5pX8DB4k7tz6zt8WDuTASaYUHvnsbYsFhZyeeLnB5POe7DcfyPdAMXv?=
 =?us-ascii?Q?gbkLoUZW4hHrAGUHv+XwqzJMR3rtjcmevTtaEaO3XaSPaMZ79SJJ2qeyVh4C?=
 =?us-ascii?Q?eTLPAdXkbfLKyNKBSxeCvWS5ZmZv6erVbqm/ZSVhvKw9A+xRpfpJYeTSliF3?=
 =?us-ascii?Q?iN3pMm9dkWRC0BLDRJhfy/gU+uRJkdaXVDWnJF1uI94EsH5O4gn6wEZngxy1?=
 =?us-ascii?Q?9vk47+BeiW02oJTLdBwBcmegYcMMLFROznBGokXjTE0CKzW1lgSR8T1nXwtN?=
 =?us-ascii?Q?Uv2CYYCQ1WpM5aXi1Wfc2BwREfhyJ55df6ySotDTBo6mkfhyO243e76zcST5?=
 =?us-ascii?Q?XMQLoJqEVzVTvSN00YLNXdL8wd3bWFJGpzhZEGZhNBbCUcSWpI6xUqzhsnm3?=
 =?us-ascii?Q?8bo+1aXd0ZTIC9V4SdQpEvF2UewdPHn13hjeq3qsShf8CEJ9xgYeO/RmNqha?=
 =?us-ascii?Q?81ya63TbMvBlrZGiuV/irRZPF+ScTIGkKUeZHW/L5TjGW+y1TF91vA5PBlc9?=
 =?us-ascii?Q?RWcrfvKh/uCQ+gdAltpBHOquHGj9bK6EEykCD6pf0HR2FrBa1TvK8ugpI8gb?=
 =?us-ascii?Q?feqNbvanRFsTaxgK3IM2w200gEUhKZVbvZHAr2EN7J2L/vbs5iAdF0koPa3U?=
 =?us-ascii?Q?P0kHMep6stgOuH7niAS9H4YKmlhdhtZMXvVBMdEebDYqhOm+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6137615-9af0-4c19-06d5-08de94f54a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 22:30:36.8195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uo4cG8NdJpjZDWHq9b0/9yZTlBm7BdmmnNCQq3oOJVJ7b+9WVoqrtSztuUeigLg2sAWJVdutvloK7zRY6guXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5745
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10061-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SA1PR21MB6683.namprd21.prod.outlook.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,hansenpartnership.com:email]
X-Rspamd-Queue-Id: 64C9D3B5525
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Li Tian <litian@redhat.com>
> Sent: Sunday, April 5, 2026 6:54 PM
> To: linux-scsi@vger.kernel.org
> Cc: Li Tian <litian@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiya=
ng
> Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; James E.J. Bottoml=
ey
> <James.Bottomley@HansenPartnership.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; linux-hyperv@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] [PATCH] scsi: storvsc: Handle PERSISTENT_RESERVE_IN
> truncation for Hyper-V vFC
>=20
> The storvsc driver has become stricter in handling SRB status codes retur=
ned by
> the Hyper-V host. When using Virtual Fibre Channel (vFC) passthrough, the=
 host
> may return SRB_STATUS_DATA_OVERRUN for PERSISTENT_RESERVE_IN
> commands if the allocation length in the CDB does not match the host's ex=
pected
> response size.
>=20
> Currently, this status is treated as a fatal error, propagating
> Host_status=3D0x07 [DID_ERROR] to the SCSI mid-layer. This causes userspa=
ce
> storage utilities (such as sg_persist) to fail with transport errors, eve=
n when the
> host has actually returned the requested reservation data in the buffer.
>=20
> Refactor the existing command-specific workarounds into a new helper func=
tion,
> storvsc_host_mishandles_cmd(), and add PERSISTENT_RESERVE_IN to the list =
of
> commands where SRB status errors should be suppressed for vFC devices. Th=
is
> ensures that the SCSI mid-layer processes the returned data buffer instea=
d of
> terminating the command.
>=20
> Signed-off-by: Li Tian <litian@redhat.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/scsi/storvsc_drv.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c inde=
x
> ae1abab97835..6977ca8a0658 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1131,6 +1131,26 @@ static void storvsc_command_completion(struct
> storvsc_cmd_request *cmd_request,
>  		kfree(payload);
>  }
>=20
> +/*
> + * The current SCSI handling on the host side does not correctly handle:
> + * INQUIRY with page code 0x80, MODE_SENSE / MODE_SENSE_10 with
> cmd[2]
> +=3D=3D 0x1c,
> + * and (for FC) MAINTENANCE_IN / PERSISTENT_RESERVE_IN passthrough.
> + */
> +static bool storvsc_host_mishandles_cmd(u8 opcode, struct hv_device
> +*device) {
> +	switch (opcode) {
> +	case INQUIRY:
> +	case MODE_SENSE:
> +	case MODE_SENSE_10:
> +		return true;
> +	case MAINTENANCE_IN:
> +	case PERSISTENT_RESERVE_IN:
> +		return hv_dev_is_fc(device);
> +	default:
> +		return false;
> +	}
> +}
> +
>  static void storvsc_on_io_completion(struct storvsc_device *stor_device,
>  				  struct vstor_packet *vstor_packet,
>  				  struct storvsc_cmd_request *request) @@ -
> 1141,22 +1161,12 @@ static void storvsc_on_io_completion(struct
> storvsc_device *stor_device,
>  	stor_pkt =3D &request->vstor_packet;
>=20
>  	/*
> -	 * The current SCSI handling on the host side does
> -	 * not correctly handle:
> -	 * INQUIRY command with page code parameter set to 0x80
> -	 * MODE_SENSE and MODE_SENSE_10 command with cmd[2] =3D=3D 0x1c
> -	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
> -	 *
>  	 * Setup srb and scsi status so this won't be fatal.
>  	 * We do this so we can distinguish truly fatal failues
>  	 * (srb status =3D=3D 0x4) and off-line the device in that case.
>  	 */
>=20
> -	if ((stor_pkt->vm_srb.cdb[0] =3D=3D INQUIRY) ||
> -	   (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE) ||
> -	   (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE_10) ||
> -	   (stor_pkt->vm_srb.cdb[0] =3D=3D MAINTENANCE_IN &&
> -	   hv_dev_is_fc(device))) {
> +	if (storvsc_host_mishandles_cmd(stor_pkt->vm_srb.cdb[0], device)) {
>  		vstor_packet->vm_srb.scsi_status =3D 0;
>  		vstor_packet->vm_srb.srb_status =3D SRB_STATUS_SUCCESS;
>  	}
> --
> 2.53.0


