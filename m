Return-Path: <linux-hyperv+bounces-1596-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD748688F9
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Feb 2024 07:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2831F234C9
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Feb 2024 06:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A66D1E4B0;
	Tue, 27 Feb 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f7cSadiR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11020002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE65256A;
	Tue, 27 Feb 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709015483; cv=fail; b=ref8/nFN7WcOS01JYXsS7UpcdTffLa0HgtwHXdyGC5P3EA53Swcuhs8gjW9zbW8jBJhGzB5EYFfcqJI4lAGN7e4+ckzbh4TXWpiMIyKeoLsPXKDDgo11Bd5mMLTuACTLkgmVAzkUFZ5Cs41gXlLqJcTCWa6sf94qHW6TuDv0tbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709015483; c=relaxed/simple;
	bh=Y4PYnzyg9Cx96k+tXM9MvLSH30N0m1uqJQul9BVVCkQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=loq+jaV2ZUN6J7Vtqh7w1Vda/SVcMmUbXIKg+vbTSAqmcsJRdCS7MBbLLNmlknjisJxYGXGyPaGL2+yIhMc2bwokTaMQrmeG+/APoolIrOcQrOjiHgegz6FEme918wgnwDqb3wrmZIN14LZhHUkepr7R5PLbzBpR9C4jesDIeo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=f7cSadiR; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFuAcgevbBNZEoPsXGUfE8FndXiQowrRVrPQoLIncpRPRo8WOLFTRLtaMhlikInwK78xG54hNyNu8Cp1JyrwEHMRU256WnHyokaLuNe+G1Y7Sd5F33LJRREbTKpK2EiSeSd8pC2iJkL9PsJg130h9BkjAfl3o7Qa1OulEGlwlWINIbEfcjyg3h4M/GY86ePFT7u5LAaLq2Dx4X1TcE6gHaicGFwnKxm/RiPYBRCh9L7dHFBe+Nzx71s2ppRXm5CBPz3lMGAZocWMHozuAwp43NhSMhairUeNSMNnwTxzOVmvFaXvYhTlHN1zU7ZCDfZ7SAZFhkTs/Y0r3/N1hWSngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaRa7BPmEVdtJ5Jo/WyzcxReFQyzeSv3Eqa5iQdXr7Q=;
 b=b4WfsOyNG4PxVpffhwRYFqo1Lvg+e1Zjgk6gM45RwWXYaDtStGxQ5fkE/83bLQ8haQsmEfTQNkS9xdOhuFEvPZd6D2mM0LqXuAgoxuE0mcVbrFQgrxW6RFOkvHRcLmlboIPv6NXUMNJgHgU1zsSeB+gigak2We0cTG7kf9/FgJtVUhQEe3wqIMMivkjZMuH2HCdLQcT2FWOP06OZkMv6qAbfkbTqVZ75beR2SZHEv4WUYSEZlJwDeAxiyzvw+NwvaiKXvmkqOIGGudGOT+Oi87e/HBRDtkHInYkd1UzpjFTEZNIzp9fANNxNNPMbGCV/0rRTrw+Pg86vvQBQLjro4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaRa7BPmEVdtJ5Jo/WyzcxReFQyzeSv3Eqa5iQdXr7Q=;
 b=f7cSadiRROUS4wV6loB/gSSIIF7pBjb/XvBYjGU+KCMx6x8tAkiQ1vsySYKrtWawcbhsjLvBtpiC7aQhfdkqbcbi7g/kP36MsRQxqWCJgpRD6jRziYIZshG2daJN1u5no5fL6h7nu10qjN0YdeLv2c6BDxPTalBydADNbHtH1XA=
Received: from DM4PR21MB3753.namprd21.prod.outlook.com (2603:10b6:8:a0::8) by
 DM4PR21MB3106.namprd21.prod.outlook.com (2603:10b6:8:62::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.10; Tue, 27 Feb 2024 06:31:18 +0000
Received: from DM4PR21MB3753.namprd21.prod.outlook.com
 ([fe80::8c16:b5af:f882:825e]) by DM4PR21MB3753.namprd21.prod.outlook.com
 ([fe80::8c16:b5af:f882:825e%6]) with mapi id 15.20.7339.022; Tue, 27 Feb 2024
 06:31:18 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "mhklinux@outlook.com" <mhklinux@outlook.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Calculate ring buffer size for
 more efficient use of memory
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Calculate ring buffer size for
 more efficient use of memory
Thread-Index: AQHaXkSzHJ3Ld4NiOUmx8Lf6f9+/XLEdzvSg
Date: Tue, 27 Feb 2024 06:31:18 +0000
Message-ID:
 <DM4PR21MB3753FBF2578EA6264986EDC1BF592@DM4PR21MB3753.namprd21.prod.outlook.com>
References: <20240213061959.782110-1-mhklinux@outlook.com>
In-Reply-To: <20240213061959.782110-1-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=828672ae-65c4-452e-ac4d-5ed3c1f3fa16;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-27T06:25:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3753:EE_|DM4PR21MB3106:EE_
x-ms-office365-filtering-correlation-id: 7b17af1d-5368-4454-fc70-08dc375db4b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rirLPM2ljsbTuAPG6VmmUtET2FeV6lU99zJmierG7BqjNHQ+rg5ukWN5eDNRrHbosjlnD9f/eNjpfyzg0NoB5Wn8M6y1gio7zL/TCqnNVaX88VHG9CGu5eDjCPv36fGfi4ZE+gcJkFXOhXUYo6fr7CAyl9mXi/4JVjfqosgC9mPWeCO8nlMdFQORB6n4szPkzCVVjjRGb+GFTCJtErucwnyGWmuWEuTjH0/vXDNmk4K4oNh0XitKP1/Cu8uWFuTDQUvFMwpZeKVO0InjzJ9cQG1MvKES+iF+hBGO/+ph42BbXIxwijNi5tSHdxTxBh4QUg6d0is+mKFccooTQGMoB8v9ng+z2ltWIPSPuZc9ugkEB39fAxB9m22LrEsS/VFmsV0gJevxUyTjjeoft9h+Bv9spwypuBnkLG3//AMQ0FcnS5hA5LQtbfIIGBBfq//7xcoTF1UJ1XYj3F7mGIVBEx0axEwYXlODlBzCBcDaeRdz7/0n8yZcuBzvHLUrnBNZhR9TPIilPUhYXVcn0Xqms4B48pwGfyVhH/shFCUUGmyvUCndnjpIgXYUjIZ3zffQQgz1wGvxwdesytsHQciWTGEXP86wdlP8NUzVCwsUELzNdhnheTQvWfos/3iclogypWyUCCxZydjORd/t2p+Misr3AAHDS5lhUM28Vl5EsQE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3753.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S1pivDOwWEQURTCpUOCT6XUZv+vURHve4BgkIrDGWqL627BnCSsLELYsA80z?=
 =?us-ascii?Q?usZsH884qkqPSfkNROWj6IUoVy0HzmNYYVjRVz4RSIQEZ/ua9hx7ol5URmF0?=
 =?us-ascii?Q?UJCb73QQtu6r5qkFqNkjxziyAzJ9NLjBPU9QPwkH30RbPnc8nqi/qoXViGt0?=
 =?us-ascii?Q?pM2FVn0si6xASXyndoywjTtnAaxZ/e/Jo9s2higKHpy1p0LfdGzI893sJVxp?=
 =?us-ascii?Q?Bsb+RdFughuazAUNnm4ewBDd4RZ8saROhNdl2wN9wJsCez6Izyzs4eIHpSvo?=
 =?us-ascii?Q?oHQ2R4F5nF0Mub2Lfi4Zyptg2riIlBZrgGv3GWyCd8PQLnaexM8b2+VzQPjp?=
 =?us-ascii?Q?Hx/2h6yf7cUnbTjwutR8tXiEcWVvJzMm4nQHdWxecxDWd6SOjZIN198a+4Nf?=
 =?us-ascii?Q?ggXvNGTfODM3SkgrdYjn/Lwfqpq9Vh+zGvoEViVWvzyUU5J2d/oi72huezzA?=
 =?us-ascii?Q?uYKK+rUHaWkB1hHnPr1c7jR+ilExlC+rHdTsYHn4bmcxtUGyEky4yv4ol9Vb?=
 =?us-ascii?Q?YybSV8flhsoHc2sko7BwqHvB7RSJadqa9KyJxT/48jg9FMXkL2+vn4lj0uWf?=
 =?us-ascii?Q?lez2+GrDjFWVppWcrJQFechvuY3VFDdE/ku1ubgGcqGNzVc3GWy7BboTD9Cu?=
 =?us-ascii?Q?tuCopYYypre2ZrpKkvMJ/WRqjTwU+gQi65x/XNubesp7I6GzIsO9DADcnxa1?=
 =?us-ascii?Q?7mPztUWWKUR+KHekaTLhckdHcyCf9ZbxTm8REZxeV6qLohoD/kjdhyzoYVQx?=
 =?us-ascii?Q?WX4PzPNWjO/oVASDx2KbTvFuthh1CaIwBnW6lmWkQ/S8abKk7B8faxJpGrXH?=
 =?us-ascii?Q?ppob6uH5GzgBbNtLx40tfME7GeNEBzbfXJS6wGNaKBN1SC/7dtuGdJwVkJKt?=
 =?us-ascii?Q?GxH19/A/VmAin3flj7xezA6jiVvfb5kOJIzhinF8tAVs3qX16d9GJwLtCeLe?=
 =?us-ascii?Q?tYRHdnQTFmIZjlPaqnHQwnCRXbNVW1oBQrzAgD7cky2Dr2HGmFfZa4lynckV?=
 =?us-ascii?Q?9JVR+kGc/cN3CwlIhT3SjGzRiLNzfOz19Now2AV/KchCjA90EVrW+2KQAI1v?=
 =?us-ascii?Q?qru1xUCXGVW5Q9DyDYOaxMkgfv0wTWcXTm8ymYzFAob9AeGFTruJ0NKX5ufa?=
 =?us-ascii?Q?tuW21nE/lKvE9NmT4I+NfMsPKPGUBgfrQmAAFDgRNuXQRAwBgZYrNG2LldOQ?=
 =?us-ascii?Q?gMOPyt3JnNc+/Z5jp9v6hG7bxPUFbpFY2nUAgvyHhgyXteaiuInkqO2Mq+VW?=
 =?us-ascii?Q?6r8ghSXgkQD954/QtvTDVcOdgztD3JPV5q2ilOJLNpHtjv9RJHf8Ke8/hMMh?=
 =?us-ascii?Q?AUFxkSm9rIEuBH6CoDnYd8lMOpcujHPr1l0+7aMxRrOM8D6YNwevzsFuKNY1?=
 =?us-ascii?Q?cYwFNjiN2rNeDLnEu5trjOv0U8gt7kdGdq//h3RJkVw2+TWpJ6GFPVIRSw0g?=
 =?us-ascii?Q?6hWFe8TYQzRlY8mDdbCc+LsFCi28YS4494iD5MBxwje43NQaYi26rc1NdAsq?=
 =?us-ascii?Q?tzY8qmo5tx11jIcxLBMBvh8qnxSLN4ccq/b5J9Lh5+ZGpAtiJMSis86eh0wk?=
 =?us-ascii?Q?ZfVLUlwr7tfjQTbQlbc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3753.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b17af1d-5368-4454-fc70-08dc375db4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 06:31:18.2736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxkrcUyap2O3DEmSsOt2F4Jw+n2ZpQ8GyeiDpvluJ0t2tYtIHXebCY0bojXwWgh0ArDtIqemJir4/GFqac8Q5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3106

> From: mhkelley58@gmail.com <mhkelley58@gmail.com>
> Sent: Monday, February 12, 2024 10:20 PM
>  [...]
> Fixes: c1135c7fd0e9 ("Drivers: hv: vmbus: Introduce types of GPADL")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---

Reviewed-by: Dexuan Cui <decui@microsoft.com>

The info below would need to be added:

Fixes: 6941f67ad37d ("hv_netvsc: Calculate correct ring size when PAGE_SIZE=
 is not 4 Kbytes")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218502


