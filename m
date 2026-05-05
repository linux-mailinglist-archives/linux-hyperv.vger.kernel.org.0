Return-Path: <linux-hyperv+bounces-10639-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO6lENgk+mkzKQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10639-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 19:11:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D955C4D1DEC
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 19:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46C97301437D
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 17:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4247DFAB;
	Tue,  5 May 2026 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="X+6rjhJ5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022077.outbound.protection.outlook.com [40.107.200.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21EC366806;
	Tue,  5 May 2026 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001109; cv=fail; b=DLIfoF7pwdpt2n+PMtAxUw0dgnnVE1t/NnPsiqpKSIw6XOQH/nT3TfkRyjtkffBILYinTsaM+xM88VXK2fXBeqaFkc/enIho4ifLHJrMSYWO+Xc3f3U76jpxfEDaKAc14erTdklhPqsDVLkwQcAWcB/t7sYpo6pJGehD7iOSVg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001109; c=relaxed/simple;
	bh=EY6n0khCZKvrTe+bfM5RK4UyIZKGsZKJ18tC/f3WvVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FnMV0qdVPnPTU+6LxgMPencXTFizai/XVeHkxT3VQgwoAarrUdKlrYPyhwocA/zIKqyffNU0whuibTcmkrKQf/j/NfCxI7L6+IE4BQj/5uDHCEjrHrVrMyuJ9pTYIf4NLjr88mSdOOQQ1q/kGVIB5+Xay21+c6wJggOUqswh334=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=X+6rjhJ5; arc=fail smtp.client-ip=40.107.200.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFSqzZAdLRMkfDtPpnrSPWDITdxSBoUuKG8P7RLjaot2rxKZ525HmX63BTIA31k7lRQg6gbnE333NSd8vjwRH8t4lYz+ji78XvFj97nDCTjhzzWsGOmAuFOAXtbpSMDOIIMm8IYNDigY/rBR4MqkTmECAdcZhcpRWlUashDej5cGoxhqXjUQBfe9N89+HY2Zl0I1eDuUf9xWX2A92CJYFZMPXcavVytq2AAXYiFNO/UZ6rRiGYnR0Dq4c16ls8dMEtblzVdh9xT5QNNKiZkPd9m2+G8W/3FCi7O58vncWREhG73tFm36BFUNk8AfGPJHGCeUVD3hjR0Di02oFG5lug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yo0vCGOaH/8uRQGJL2GD0Mac0+04Vuk3RIubeHoQgwE=;
 b=Y6/MR8V5Qo8I/3DL1TLSg09vgJ6/81+kTxl9/yLizXiKTm5/j9e29BicmFNIpFOUjhKKN/VjOxpOEpoLK8XoI89pgN9ZX6+M+y1RCicm/zrsFDJmiP9cybBhyjmgr2et0XTdeDykVBbC2nnjijYbLnt0BtzuHN7/DGr5W6yzLZuhhSB2UH+MnVbmg0+7Jc+zvcLeZIPBdLpMoTeOXTMVcUIoJ+sx6QsZDCmieV6yXVd4fUV+hqLdrKH6TK8R2A/zUrmDl0+s3fwr0wQqBPOkBlDzN0AOJpUpd9jkROmeiC64kRbbQT27Rb6QXVFuWzg0j9/2s/En4+XTih9Hwge30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yo0vCGOaH/8uRQGJL2GD0Mac0+04Vuk3RIubeHoQgwE=;
 b=X+6rjhJ56e1Pew0vZ8T6boJiFhDAatT9xy5/oNvds6Ea4TOqp34MMRp8tyB27lLm6Jqg1OM1OROWHCxU9OXiVY//ZSJgNUHmNdzbCZtZjKr4a0F8e8Z25jYjOdHJT8OacOtzCzs6NgfqMh6wu4AqCyxMsAnfs3OuQRy0duyTfyo=
Received: from DS4PR21MB6914.namprd21.prod.outlook.com (2603:10b6:8:2e5::9) by
 DS0PR21MB6433.namprd21.prod.outlook.com (2603:10b6:8:2f0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.2; Tue, 5 May 2026 17:11:45 +0000
Received: from DS4PR21MB6914.namprd21.prod.outlook.com
 ([fe80::ef10:ddaf:4d07:7646]) by DS4PR21MB6914.namprd21.prod.outlook.com
 ([fe80::ef10:ddaf:4d07:7646%6]) with mapi id 15.20.9891.004; Tue, 5 May 2026
 17:11:45 +0000
From: Dexuan Cui <DECUI@microsoft.com>
To: Dexuan Cui <DECUI@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>,
	"matthew.ruffell@canonical.com" <matthew.ruffell@canonical.com>,
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>,
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
Thread-Index: AQHc3Cj5SYifASCvgUCkf4bDaRgCsrX/q7KA
Date: Tue, 5 May 2026 17:11:44 +0000
Message-ID:
 <DS4PR21MB69148B68B8295DBCB6BFA97EBF3E2@DS4PR21MB6914.namprd21.prod.outlook.com>
References: <20260505004846.193441-1-decui@microsoft.com>
In-Reply-To: <20260505004846.193441-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0397ff6b-a34b-4b3a-88d1-6890b6fd2aea;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-05T17:10:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR21MB6914:EE_|DS0PR21MB6433:EE_
x-ms-office365-filtering-correlation-id: 71822afe-224b-4df4-4e46-08deaac96269
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info:
 n2DETJ65JZpioOAvhRGNGJkT4vQA9+znA+S8QG8SASSS3rjgWcpyEcsfOhz++FaUxLUY1BvkJ4MXlitaaVwtJuvEOCoqsF5gqb16wqvEzDpXM6e6kBLmJyxWRBHfA4s3qr4tSi8ZbIh9RhEocvWAdGeskwcKKPJS+wd5m5QE3UcHqCRb58+Cf6iCOaKpaoKggw6fOvXnKIgqIImrKbsln1/muesILfceQANkVK/HsQ/wbAIPhMnUwYnSEKwLYdQt3qN3XLyZBjBcaDLXGrqH6/dm21ipdp8SqEMZdAW1AZLTqIXpvt1OQaEruwBsp90ivsMgyJCKBEjQK6zVzD7guvMiN5mkCVYAjTJEg1dV22YjTZGAvQG2dis4VXs19eUcGsf9Ye8yD9XXbbXGRBdgvURnpZ4YExirFHNx1Vj6gbenHGSQaqDzH+sQ0lmxl+lQoby9JRUYitB08Xjcaan9B0ZrhCXwsCz9RzZOW7KL/4tUueFe7qnWiZRoMVcTbuKVhnv+AjynUv8i79BaABO+IfgoWayBj6gGSXdKfdrlSSYjgMloTZZZVEB4pY/bY8j6lIxYGcaCUDlaN6TMmUbYDPUDwNMlqazFtIRTPdU2VYlTwFgXb9Gw4cTm3QN5j7x4h02GNZETL7adboZwfgGpTr+W1uurjpxjEuGhE/LzkiXI0F7JtZfVSdyvZuC3dhpHHFmNKesLnsJVy85wLcz8HoYrDuTULN8a+w0H+gYlMZlT/tI7XfFWCO5MMzQXyHrE3S1xHy+3SQnH1TuLYkHBPQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR21MB6914.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Imkn+ti0n3Scf8pUMXoNHbmi/DiYjz0Gf4qjHYTnFVgtQPyBUfEOgSuC/fwH?=
 =?us-ascii?Q?74QdiXjPCvFYg9aNc1Qsuz+2R67vwkSzZg+VTiAmURLKXImEinULBWKCKk8v?=
 =?us-ascii?Q?jRfOos62Fq97+ZXjgyXLQP5iDTmqiwBwlgip3BH203agUIUiN67SEn2hS9FX?=
 =?us-ascii?Q?5EMmXG3exaQglt9p2Xx4MvvN3VBEFVEHWKldsjY7AFpNBCdxBivq+fccnEFi?=
 =?us-ascii?Q?nl9+lZvq8KlplrphyuomF83KajKrPDgEaN62hM1EzKJAplLvkAYxMpUCK5r9?=
 =?us-ascii?Q?IJkibPSKnqlW6j1UO2YgtSDkI/PJeoF4atKM6PvJNiC0jdyWQGVEhc9q82To?=
 =?us-ascii?Q?xe4rMRFKsm2CDtUDK1/033SZa70jFZ9zaEFALRLdKV+U+XhOxcAomuBdCisy?=
 =?us-ascii?Q?qxzMIOyX6Z5vRaGMTR+p6rOin9a78dR+ofpZ32HPahHav084l/ia0m5+JYli?=
 =?us-ascii?Q?GI/VnQX2pHhIqMLBuJs9xanl4LTImi/RdNY/stE4ck6gmYnhTPI4LTx5Fvly?=
 =?us-ascii?Q?NJJXPg9jxlI5fn/lft1/odv1DRcvgbtILge4oqXsAwsmlw5ffV2E6YwFEhPE?=
 =?us-ascii?Q?N4gyTtNXh/nW7LTw8gWgS2YNEwL4VzQ9kJdUomoOM4fUiBBkFvHPCKneIEL9?=
 =?us-ascii?Q?MTpsBfJZ71zeh5dhuVIvWE8H8CchjakP1S0NnS82IjNckwdVqroeQ8AL7xFv?=
 =?us-ascii?Q?MVcefVn0v871pynFfL/PyuRC6/4rAjzpD2VIYl5tbppw/bca6UoNJLbWIQXs?=
 =?us-ascii?Q?eNPtHUPE6ZUYur2eDiLCCdELQZVT7uZ31EdpM78hxcva/zNjMQ10bAiK81Sd?=
 =?us-ascii?Q?+6hGPifHSUiS3cah+oLkMwzV45qkOZRfX33PV39KgLFvuxEDZU4Nli3ngX4J?=
 =?us-ascii?Q?VFiH84kSNoga/SdLfgjs9xyZU1XSTPZrXanqLLaGjjmtkj7BXSip27Kw+a6F?=
 =?us-ascii?Q?oowxU735lfWy6OE7iW6LgWZR05KdBUpdC0qwuVpFGD6EmOaHhTqRfczO/SGH?=
 =?us-ascii?Q?dF0VZfc60mDzqUnXz0Ad9vpYWnfdFAePvuUrLEISXCn5btr6dxNwZJTYAsc9?=
 =?us-ascii?Q?ggxP+sKf9HmhrqZBugOVj0z/sJVtnd58QjiGHyPTh+CQSROjcsTMfMZV8ZM+?=
 =?us-ascii?Q?yQgDLeF0AvyES1yKIn5p5Q8MXGHFi9QYGz2PChy4W9u0+xxkz45vN+Ioxbpt?=
 =?us-ascii?Q?qWC9YQ1X9u/rjPpU+kmQLJmASqDbfvIBhkQ+5AGiKFOSTmTzPG+ul/bG67uz?=
 =?us-ascii?Q?bx5nbaeZEj6nmvOVItRWtysT7dCNS/FD7OdH5PK6ppRTmXKZe+szoZgAYfrm?=
 =?us-ascii?Q?F52zEFDV1Q3iK1rtuR8904ZvvFoOXUa4YTbQ//e2rPONoye6HwU/azyNfvt4?=
 =?us-ascii?Q?8H5MX5vTDE1L2Q9fv116/zDmz2YwgFHaxWRgoc1QhOj6s8myo1PlCIA1nG5t?=
 =?us-ascii?Q?pl02nb06cOa3Nm0P1MIQGjMF1p7VqDRBSPBcpIwLSQkkCkZ8r29HGPRvqoS4?=
 =?us-ascii?Q?/TLJ2JUpn4BEGIzHTUNvUENe933wF/FY4mT4/xwqnX34uRlGJgqr7dIBpByQ?=
 =?us-ascii?Q?WKglOg9gBnLbcSoz0I2Eidl7MsIjvJbcHTm1/hmB3VlpDjRbCaZpUTp1/6qE?=
 =?us-ascii?Q?JVoLRrg9ZBCA7/qPOdOyAVKRhE5ksNtdks5qxnjSBRu6RVzAzOmvG5eHK41r?=
 =?us-ascii?Q?SaOQY+9j3CLbERb1wjNoDWA+FX5aNET+fhnz2vfRh6wKgJvc?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS4PR21MB6914.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71822afe-224b-4df4-4e46-08deaac96269
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 17:11:44.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzdzSsjc7dZQEkvfiB3+WPqKGsZv3TV9BqegZw+T85mPxavgUoNPkDKn/gE80ZvZ3Uj0PVbrmgrPsDOZZ2F8fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB6433
X-Rspamd-Queue-Id: D955C4D1DEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10639-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com,canonical.com,templeofstupid.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[DECUI@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Monday, May 4, 2026 5:49 PM
>  ...
> If vmbus_reserve_fb() in the kdump/kexec kernel fails to properly reserve
> the framebuffer MMIO range (which is below 4GB) due to a Gen2 VM's
> screen.lfb_base being zero [1], there is an MMIO conflict between the
> drivers hyperv-drm and pci-hyperv: when the driver pci-hyperv's
> hv_pci_allocate_bridge_windows() calls vmbus_allocate_mmio() to get a

The " hv_pci_allocate_bridge_windows()" should be changed to
       "hv_allocate_config_window()"

> 32-bit MMIO range, it may get an MMIO range that overlaps with the
> framebuffer MMIO range, and later hv_pci_enter_d0() fails with an
> error message "PCI Pass-through VSP failed D0 Entry with status" since
> the host thinks that PCI devices must not use MMIO space that the
> host has assigned to the framebuffer.


