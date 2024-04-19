Return-Path: <linux-hyperv+bounces-2004-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6188AB14D
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 17:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267DF281F77
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Apr 2024 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DC012E1D2;
	Fri, 19 Apr 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SxDGXA47"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11024022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36812DDAF;
	Fri, 19 Apr 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539271; cv=fail; b=Qc1DKNgHhLjXRnbdw0EJZ7qLI4CxmJsY4LmEadYTe4NoMVM1hvqbKbhScLMeRGjeyligTGO3AR4aFeoPTQxW3UwFXRVXaXM+B/gp4JY88sac/QzMZRDzIXk4FxiZrrhFfq0KAo7ymEU8h1U86KDWLLS3PGFAJbyKpuR9F/dbK5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539271; c=relaxed/simple;
	bh=AZdgxCjdfX2/bEh3t1aIMIBON7KhDUAg8wHZ17x70C4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Aw9GyZaiU0g/oTh6DtlTBpZkFWUL49fxXYiLpZZrqfgXsnH6UtokWzSrwGMBpkLPg7zt/BZjy0ctnyEyHMd/nKq2U3JbobYrKiNeDvbuFecEAMT6wuu26PmEQpNZq4ZjpNNKWBl//fqtePd1OXTf4+K+HA8kEZX5RDbdxD1XhwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SxDGXA47; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgfNa2OJy9whTNlpAMtSO1qBgk4mdkaNdq1TWWioCxfuomWpvinU8N3xSFYUH+v+cxcqv/5pwIuqz140zcv3dP5qmIyt0jxvmt8uSV3c16cznIPjsJ0Ek1Aww1mM8fPbAcqapOo19QMGgqtSSalAFAPy83PyptaAJzf9YzwkJ0JdEMvi+H/15h8ana7+xtcOpRd8tpZRFel7h2rGj7kGyPcDehQgm7m+Nt+pUCzZQFKdhyf4tfKGu3323BgWA+eqMKAl+neultRq0ymUa53cD5puX7GMpuhvn0+Gl9SaaI7NbecXZxzNTuGeRfwVHE0n9IGxKDt5IsdochpG/WKAMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57SZcENqpirWVpUN9803jXAsH42eohv9OP9bgwPe2qs=;
 b=iXS4cBqFEejD5A3J37bZu8rjb/Hfkm3oK6htbSqR/uKN4UVUgZ7rwudXblUNqk4fvWdVorSr6K+x3XPXIbiG5rDlUP4nDpr/l9sx7jo396Li9YFwhSO0zfi0ZB+IZMHKZ4GTmpXf27ryCkj197vGNxUHvDkwEyyCtNBMditBcZuglNpAND8fOgJk0F3AqHrlVJSgSw8GHc78lk94pJpfsnf0p9FC7xFtyUdbL83N0165J0fd0dpXC+AIFp9bQkdBcW6QuoUA/tE1QpbvSkeWOAConrLupFT0JXVPrzzUrcTQbWGz48sXQ0m9G/hE3yDvI4lPjm4pS1GZ7h0UBxSs9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57SZcENqpirWVpUN9803jXAsH42eohv9OP9bgwPe2qs=;
 b=SxDGXA47AV7ueLnRgg81vJXbutARQ02Y2I6+rsLfgn4A+znW2XxlKNNgFjFBxrK+X6ugiQaK5XEo2OHjifMzJ7bypnVCFmvh0eVbpklqTmWQjLn2D9UFu5jtGkivPjFndUF1S2Z7KpGBsKzagZKUlV/wdFxa3Xm4s/GBSTL07Hw=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 CH3PR21MB4036.namprd21.prod.outlook.com (2603:10b6:610:1a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.16; Fri, 19 Apr
 2024 15:07:47 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e%4]) with mapi id 15.20.7519.015; Fri, 19 Apr 2024
 15:07:47 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, KY
 Srinivasan <kys@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Boqun Feng
	<Boqun.Feng@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH] PCI: Add a mutex to protect the global list
 pci_domain_busn_res_list
Thread-Topic: [PATCH] PCI: Add a mutex to protect the global list
 pci_domain_busn_res_list
Thread-Index: AQHakfxj93z/Y5X/10y0l0FjynaRDLFvpNpg
Date: Fri, 19 Apr 2024 15:07:47 +0000
Message-ID:
 <DM6PR21MB1481CF0C786F3FB367D614E9CA0D2@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <20240419015302.13871-1-decui@microsoft.com>
In-Reply-To: <20240419015302.13871-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=47b5ba1b-b965-4577-a8aa-e669a7ad75c3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-19T14:18:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|CH3PR21MB4036:EE_
x-ms-office365-filtering-correlation-id: b3d46ad1-9be5-43a9-043a-08dc60827902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VOOTwB8fFsmDiTGAUwJdUJS7wRq3n1RlVdIfBTTlU+wNfq4ERB8lW4GOZGlE?=
 =?us-ascii?Q?d+7bG12hcDcIBxkTCGfFPcodUfFC/BG1kW+sTGHPOLS7yMXRAX1IYx/MjCjj?=
 =?us-ascii?Q?JIh4ZZS94iKwknL1suY+cCTRgvhiCQudGr25xYps++P83Ebi+h5FDYCqaB40?=
 =?us-ascii?Q?mOWhDqFek4IdhaUH24X89oSxFdW3YPcdAubCNmvPMiQpdMG1CFzLESIWQ8vB?=
 =?us-ascii?Q?cgA0SkblJkDHmJd1xlKkgYZFNqNfEVtPFW/GUUIR38RgQdWYeltiYNs57UBr?=
 =?us-ascii?Q?5aWkFHZvo1mD/Gv19nKZYA/9l8OK6JeU4YXhxr0/Ulu4WRur1fsvzk1KBKNw?=
 =?us-ascii?Q?KMUbf51KoBDr3uHVV3O8zvx1HHUUyjG/EpuJ5LU5+66wZamAtYOhp0OCYb9l?=
 =?us-ascii?Q?HJ3dOEgabn5oJtaI9WKZSq2T5P4r/9qsTZVp/9aLkO2uekuZnyfCep/wblMq?=
 =?us-ascii?Q?ubIBQfkDPVRoxhHMgll0hgTVSvHZR5z4U0yA/Nr/3z6cLPRKirwjT1FLGm+c?=
 =?us-ascii?Q?/8LMb2n1zoAZ5qhKSOh62v3GZoE0WDdUhH52eo/dIpwuB25jHdtUou8umpur?=
 =?us-ascii?Q?TgkVe998paitVRBUnhaoc1xNHm1x7m9X2ZIeG0rieZJsX/6roPsv3rKm0cKi?=
 =?us-ascii?Q?L9qq9lG10yAVefS6c2rKpAzGbBJVgeZFS6ViCFcTa/Z3RQsAKApPFIs8YawT?=
 =?us-ascii?Q?sHBBXMAJ1PHmHbBXtCS9Y0XeKKKU02M36tTk0zBD8rgV5whtMW4k+nPqlWPr?=
 =?us-ascii?Q?F1l1qupsOVQxMJAjhNOzhzXx3OZ7Xz4fDXDC81EQCbeis/bCkUjvFniRmA9E?=
 =?us-ascii?Q?re+ylYyTpGKpoZ38kEYbygRlqLmi3Q4e9y565SqGyas3atNh1i8sy2Inaiz8?=
 =?us-ascii?Q?/HNzK+Vl//syN21TN2Zrsmk3ruDajVzkdMXHBTnKou6PSZhLKvrrOUZjaV9D?=
 =?us-ascii?Q?R/vZ8f85Plnfp38w8bbDzi5Gy0rJnAmF7IwIpwFymRKEXc1s/P4cRppk8HCt?=
 =?us-ascii?Q?rL3hB62yrF2bKIdpQLu5unMcanL8hJfW+wRSIB/R80EDgjvDR9TIO1Xg+daT?=
 =?us-ascii?Q?ojm2O1u2Dheu13l6UDRhRL62pBN3T+iTZiMLl8406KL6TBXm+8oqVr6HldkP?=
 =?us-ascii?Q?zG4aIceLiFxmDETC8jTh01faIxIe6QLLwsCqsSoiaPjPopDqvqYFq940f3QE?=
 =?us-ascii?Q?fTY1eZygnP8+UTfFf0kHMEiUdfKSnXUs9UHLCGIHgScI+1oOhJzMlXYOXqXu?=
 =?us-ascii?Q?gjTppEVqIy1BnSUUJYimkHc3/7I7bsgiLZnPacrJZlXEflpJ785ociGSiWfc?=
 =?us-ascii?Q?i5L4zi1zV9LLzHZRIDL3fmeudRLcPfso5pAqc368cVquJQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?obCXAhKb+o6kh7EuZKJQr1j/C25crDZtpJazTFzVru9hMtnq752haK7M0e6P?=
 =?us-ascii?Q?qUCsEDkc1uvjo/EmZ1rnbDQuLR2QoF50yPTERQAsCB5gdsD2GBT06lY9COEr?=
 =?us-ascii?Q?WwBzPrdDO7W1qZnZOvkyybV2z3a3AQCqmApVTtJn73DHonIRtcYEyaHF3fCm?=
 =?us-ascii?Q?HNj/wplT2jLUlMI7rBF5VlAuHGqeVLEx8FDSgGFPuC31qjQPK9q4+ch+Z0lD?=
 =?us-ascii?Q?ykRDPQoWRxL/U0YGJAlLqgui2rI9mo5UXj/05ALPIc6Vjc8sw/iihaHAVeRT?=
 =?us-ascii?Q?ZArrKgiuVSGzpW1vaaiUObyLh+LBc/cTeGCj9Oon6mfwlto/hosfUUxgOFdU?=
 =?us-ascii?Q?bYh8vUNgP2uiJmUztH4Zl/is3SpRq2gPgRtylFoIaWxqkbAhhcMv6mIhdMvT?=
 =?us-ascii?Q?S13m6io0cUQgbwUx5orryJl1IFrH/Ua5pt2xAfyOXhMmtAKwz28wHwvt7KbM?=
 =?us-ascii?Q?vVtFU2vHQrwq05QO3g9IiONBQ6iEn1h5b7oPsZCbWQCDyzcYXXpAnGAlNcFA?=
 =?us-ascii?Q?IDtKObWCksVsNtbIJ4p0FYVlkdEKQ4ZQVz89N0mLHCYgivAsCjm2Y5U1ke+l?=
 =?us-ascii?Q?QuFPVEd2z/JaMb9mtWY6lsSGeYmCyyIn9oG90UEUqjVpYQqVLHt/CVxAVtn7?=
 =?us-ascii?Q?HYuPM/ZJrVHFGkXHWOsHclrEHmASdv/Y8hpQIum5wRKkjIB74HBLOU6bT0q4?=
 =?us-ascii?Q?qC6MdP3e8BRdtVyoXl/GHA1vNhwtZHy3jROPQFHKD9H8qu8z8xmJm54KdF/z?=
 =?us-ascii?Q?4h7/8Dg7qRNEApnykK7oKWGISWmw6dwmcIg7xw7Ax50S2uOsW7XhxoT6nDTZ?=
 =?us-ascii?Q?Fdb9wX7agUhz4Xa7jHfZUg7RdDzEzGtumIIZE74Vf3WU8dZElBFdBB0jlovh?=
 =?us-ascii?Q?C820Qi+34g+DpWkdnCeUhQ/3VZfH2hFw46W127DvrPY9Y6H51JRuidLqX98M?=
 =?us-ascii?Q?D/2MWBqm/5z/2Qd2w7awsbu2PKzsRfC3ZRZ5eWeji8Wf4q3oUC483hbBbnKw?=
 =?us-ascii?Q?1Dttyv0NvClyl/t4+6b7zi06T1Y27aCHluj0Wp2sgWH8JOXZxbFooqy9kta+?=
 =?us-ascii?Q?9R2TiHxw+agpzv9jCyS6WjQQUO/ZSYD5EXBvQuGElo9VEmujZ45pBEgml/lz?=
 =?us-ascii?Q?Ma65ubdtZN3Bct/U1um4MstLoewuX9mBC2/HhC2b4nkV89KiExpTDdAyNgoH?=
 =?us-ascii?Q?SE6nKKGF8kyvrwubP0zM1/lT9sFA9dXz1p7b3PP/B4QsI9OSP+Szkrf8iLsN?=
 =?us-ascii?Q?baS5AogNgBti5djnTvZU4pyJfOpll1DYo/L3T1w+B0E40gm3hkC50DV1j3Tg?=
 =?us-ascii?Q?rurXVwzh/FU5+Y0pnHlKApBLqa59XNVnNRd/u79Qe66MaeewO+IJjyxZITTw?=
 =?us-ascii?Q?oNYLSxlYZ1Pkp55vkTrNHi6Qy7BfNMbwPiVfhmRapebgA3kU664nGb+5+Qid?=
 =?us-ascii?Q?j5Bu5jBw9qpxC/W7EnECHxEAwlGVhGyzjArNsDbuUserY9b2CxMLo0KiHF04?=
 =?us-ascii?Q?wisjOeL03lW//fvq19gE98+/SNOV6iicG84sAFKgKsYw0aQHAGJW9tMAGo/c?=
 =?us-ascii?Q?7tqc7F5tvbMOrhq3EbgzX0FXFEDkhec4KUTkERb1?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d46ad1-9be5-43a9-043a-08dc60827902
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 15:07:47.1672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXNXHUGdnYgQfpOoHPBwCnri7noFDZqf8J0XyrvwZfC04I4N6C15IK04S0rhC3dvmXGJyNNsqGthsrBs+/1S7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4036



> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Thursday, April 18, 2024 9:53 PM
> To: bhelgaas@google.com; wei.liu@kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> lpieralisi@kernel.org; linux-pci@vger.kernel.org
> Cc: linux-hyperv@vger.kernel.org; linux-kernel@vger.kernel.org; Boqun
> Feng <Boqun.Feng@microsoft.com>; Sunil Muthuswamy
> <sunilmut@microsoft.com>; Saurabh Singh Sengar <ssengar@microsoft.com>;
> Dexuan Cui <decui@microsoft.com>
> Subject: [PATCH] PCI: Add a mutex to protect the global list
> pci_domain_busn_res_list
>=20
> There has been an effort to make the pci-hyperv driver support
> async-probing to reduce the boot time. With async-probing, multiple
> kernel threads can be running hv_pci_probe() -> create_root_hv_pci_bus()
> ->
> pci_scan_root_bus_bridge() -> pci_bus_insert_busn_res() at the same time
> to
> update the global list, causing list corruption.
>=20
> Add a mutex to protect the list.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/probe.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e19b79821dd6..1327fd820b24 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -37,6 +37,7 @@ LIST_HEAD(pci_root_buses);
>  EXPORT_SYMBOL(pci_root_buses);
>=20
>  static LIST_HEAD(pci_domain_busn_res_list);
> +static DEFINE_MUTEX(pci_domain_busn_res_list_lock);
>=20
>  struct pci_domain_busn_res {
>  	struct list_head list;
> @@ -47,14 +48,22 @@ struct pci_domain_busn_res {
>  static struct resource *get_pci_domain_busn_res(int domain_nr)
>  {
>  	struct pci_domain_busn_res *r;
> +	struct resource *ret;
>=20
> -	list_for_each_entry(r, &pci_domain_busn_res_list, list)
> -		if (r->domain_nr =3D=3D domain_nr)
> -			return &r->res;
> +	mutex_lock(&pci_domain_busn_res_list_lock);
> +
> +	list_for_each_entry(r, &pci_domain_busn_res_list, list) {
> +		if (r->domain_nr =3D=3D domain_nr) {
> +			ret =3D &r->res;
> +			goto out;
> +		}
> +	}
>=20
>  	r =3D kzalloc(sizeof(*r), GFP_KERNEL);
> -	if (!r)
> -		return NULL;
> +	if (!r) {
> +		ret =3D NULL;
> +		goto out;
> +	}
>=20
>  	r->domain_nr =3D domain_nr;
>  	r->res.start =3D 0;
> @@ -62,8 +71,10 @@ static struct resource *get_pci_domain_busn_res(int
> domain_nr)
>  	r->res.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED;
>=20
>  	list_add_tail(&r->list, &pci_domain_busn_res_list);
> -
> -	return &r->res;
> +	ret =3D &r->res;
> +out:
> +	mutex_unlock(&pci_domain_busn_res_list_lock);
> +	return ret;
>  }

The patch is for common pci code. So, this bug has been there for a while?
Do you have a sample stack trace of the crash?

I checked pci-hyperv, it doesn't define the .driver.probe_type, so=20
PROBE_DEFAULT_STRATEGY is in effect. driver_allows_async_probing() returns=
=20
false unless kernel/mod param requests async. So async probing haven't=20
been practiced here.

If in the future, we change the pci-hyperv's probe_type to PROBE_PREFER_ASY=
NCHRONOUS,=20
how does it affect the underlying PCI device's probes within the same=20
device type?
For example, MANA driver doesn't set probe_type. Will pci-hyperv's async=20
probing cause async probing or potentially nondeterministic naming for=20
MANA devices?

Thanks,
- Haiyang


