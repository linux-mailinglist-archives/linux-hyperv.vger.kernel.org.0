Return-Path: <linux-hyperv+bounces-8231-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA44D14971
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 18:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7814E30012D8
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jan 2026 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528EE27280C;
	Mon, 12 Jan 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="eV3MXOHc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020073.outbound.protection.outlook.com [52.101.193.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EDB273D6F;
	Mon, 12 Jan 2026 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240382; cv=fail; b=I1hXnx3FqJU9bN+YEeP/DKvryOmk4wKJonOjz2gS5NZasFYQxHkVCkH/cq2xuJiK5OA8Fey2UZaYP2NI7m1RO7vMIBuzBeQFyhR15BCzZ++CYfUN1tJeodtXIbUryz+uD5aGgFm15KOp/yBA2kVGARUwR7OAdeEw1c95cxVvcWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240382; c=relaxed/simple;
	bh=EmqOwDZJO0csiJjkfM3D5xqBEXdd1Cs1uXQzAwhmORE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQ8PaOM3Nw0Bqp0Yf2pRd82oRpmSR3PoiqchVDGtk7hYGWaaJLVGjIEbFiEJkkDRWT7guoOTTyV0fJsTHEJ6w6KP92pChJkjUcgGnRMAMLLpaHjSYm0Dd0MagwxtubXmVOEdWcSxE2Ju00O7Ejrfcle8luHU1C85oTeys6+tgu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=eV3MXOHc; arc=fail smtp.client-ip=52.101.193.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5VwIFwsHVZFKeOuvuvez1C7KXqI+eWLOM/9aG61bZIuFyM/UGSd4Don9SwKM5ajdGD1KRvIJMYSZzyyS7lE4PZJrneWtIwKrb3CdZeyfclz1rIPF5sfy5OGgo3hxO8EsojAs7+PndbL7J4jYfnZ1z0uAFNBBHR1369fiaa7ksCB4eQgTyqueWDHaHHvSOlgzf2K4WY5UNkUkMl18QRW5L0Av8nsnT6SBl81CwrRl5D42fyMrIEa2vdCP1tYi4fv2pnb00cv79SdBkktD3fwdQxCtATgIm++E/P3WKgZjqh/ueV3+VBHyfZGHdBt/IQC4l0qAf/3IxtiqC+TZQVbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29n1G5W8zX+UcHvjzwrFCuv+iH2PKjn9GUhIruqUPtU=;
 b=kSV81MG4po3pS5VKdaUU7VQ0DS9ldXYE7UVho8QVaFNqhigb1kWTaL68USKwAXVMFqNtdlHPIVr+B0UAfybEBmnX52z3Hm8WO6fq73bKHogfJHB6O3uNCJAsBQehl1NrY42Y7+q8FsGwI+Ya0buKwReDIL25kvClBNrbXRDKntw5/2bhKgqposm9//fZPPf6GKcnHdybrUnrUDI++asiqvyMTw2OvfCD76vhrZ6sppx3xeZT+VSQcqN0Q+AMIO+b38GPB8MaR6zJXmcXVlzg6xkT4sXDS5FTsqnLxKLwgAjZBC7ntRoIuYp5qCYThf7rObn4Sq431j2xSD8NoE3Kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29n1G5W8zX+UcHvjzwrFCuv+iH2PKjn9GUhIruqUPtU=;
 b=eV3MXOHc6p8/KHY8+HOlYq9kEIYCqQSia+Qcj8vP32bjHjVcEvbFyHhxsbolSFXAUrFIdh56UR0/5nn5uw3qEXb4LyfI58zJ3uGFK72+nCf9l3d5IuL722lz24UsSRPVluuHIixmGiUt/rbtzmVTuw528VkRoQz2w0Nnve+wfxA=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS2PR21MB5373.namprd21.prod.outlook.com (2603:10b6:8:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.1; Mon, 12 Jan
 2026 17:52:58 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9542.000; Mon, 12 Jan 2026
 17:52:58 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, "longli@linux.microsoft.com"
	<longli@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Process unsupported MODE_SENSE_10
Thread-Topic: [PATCH] scsi: storvsc: Process unsupported MODE_SENSE_10
Thread-Index: AQHcgA/R8MedZidNvU+vIP2zu6TlZ7VKID4AgAS4EuA=
Date: Mon, 12 Jan 2026 17:52:58 +0000
Message-ID:
 <DS3PR21MB57351CF7BDEF314AA21E2CC4CE81A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1767815803-3747-1-git-send-email-longli@linux.microsoft.com>
 <SN6PR02MB4157232BE7BB9B6B1AA81AEBD482A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157232BE7BB9B6B1AA81AEBD482A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=72debbd4-62b0-468b-acc7-1b930a12eed6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-12T17:52:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS2PR21MB5373:EE_
x-ms-office365-filtering-correlation-id: ca70cf60-149f-4460-a193-08de52036bd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hiHQPVicYBJQpgZCXTDK34AgXbBYoCQ+5ExbOJy2NHam1IMc02EyjOac6unT?=
 =?us-ascii?Q?cD22hI50uHzauUw+R9QbeX9jNdBLNxN/5bDnxDpn6JL8VnGWy4sBhC4P7zCc?=
 =?us-ascii?Q?0ixfoPHvYdsuJB7UxZtTPe0QZ9+kYDnpeYC0ar3gGYX2TgDIM1GNwT5y2MJO?=
 =?us-ascii?Q?sitYhBSyt9Rpi5mbkbzmveIG8JKaBZhTMAS9oH2gvhPrOMwyztGJ68G2b0FW?=
 =?us-ascii?Q?IZltx+iR29fVH/UJET0fDdBJA54AbOtpehtiP5pGs8As8ubXWWYBzllQv8xC?=
 =?us-ascii?Q?yJA1taUzZNUmHMFHxHPs0DuIk6SkZrvj6EhVRvWzZNMLc6Ipn4MQl6L9I5C4?=
 =?us-ascii?Q?KEaRQP2w3jt/ZsqTzlQqdZzUrCigb/KligJxnD7FPK0P5MBHn9fwXlmUGJIt?=
 =?us-ascii?Q?pLrvxUJE6Lmi/BwucwPI0GRVrSkTNJIHbJJqzkV7SBoqXdoItw0lEHOIKVT8?=
 =?us-ascii?Q?8gWtVARZmdzOyI0w0FYqEikSL96bQ89XqZZTHPpsex/VvjcDP/RiX+nW7AQ5?=
 =?us-ascii?Q?iSrUvAdO4eaQe6zuKEVdah66rnrkEkS9yKEAijt/f3yH16lU7ZZzEjRiHE8P?=
 =?us-ascii?Q?KDHRM7Deal4r10Ad5zdpgLDoxypR3PuTFHCRxj6qppr6IzPF8I3U44FL9fUC?=
 =?us-ascii?Q?hdCZFmanjSTe/Fv5U/MmNlKEgz3q9R55WO0QjRb7PikeRr+o5lZosmRuWyHL?=
 =?us-ascii?Q?JHHpx7HebKX0UC0ogZ20NgbIFBDNMfHXAU8x5aYD/+eo61s2MHR6Pyx5nyTJ?=
 =?us-ascii?Q?P6WWsbiMwTIai8w5tHlrfUB+Y3cq+bWhFV+qbXqBbXu8VQEC3LsNtlWELfER?=
 =?us-ascii?Q?Rq2nFDEZf4p+NO1eYHJQAoaRk7aW3iMO6hGIpykoRjRDmp1QDvKUOIMJeSa2?=
 =?us-ascii?Q?KhBWpNatQxnwlfRmOjPJABtaeBtiK0/jXI4Zl3vBfx4wKNpV+fsQ5PnQmbTN?=
 =?us-ascii?Q?7rGHtEwsTF7gezYb76bSaWd8NP2ESWZz1HmOPuTBfizB6iI0y1jFCp/eLJvt?=
 =?us-ascii?Q?TqS2Nxxf4W6Eb13QZrRapzj27PtWdM2JpbMw8EWHZoIoDb225SqGHIbipWTe?=
 =?us-ascii?Q?/XZFMbn8RbI2DtGHkKIu6kKiRRfFfj4kt9/gFicYK+keEjdbqdotgcvAjydn?=
 =?us-ascii?Q?wQvRHwI0BE+UTnkY6TYwbyy9pTjp2+As3auRyjIR+3uAZQ9pFu4piLSSUpNb?=
 =?us-ascii?Q?wyb8UNaKk/PeW5+FKCC4f3t5eGeNx3DxuCFDncrDee4P7EVoSCv9wX/qaA4j?=
 =?us-ascii?Q?qqc63c3M0c0Qlu7YRkCkDvo5oR/prP0aOg/DBfVinn9iXkQNpx4jdWGi4DKw?=
 =?us-ascii?Q?BoK4/EZH0ttHuOPpONxN4BrP8vmNf7ojqspcKJSeyeG8vlkgYOlXby4WcvDf?=
 =?us-ascii?Q?VivG7QpjnTKAEvK+D3IF62lk+9fvLNP3zAtlXaHuHbax5PLHYX01FyVHPvTz?=
 =?us-ascii?Q?AyLtxIraPSndfAcm1jdJ+u+hzfIULhsfa/WE+L1Fl45cGr9ZDDAN9KP4JZ/L?=
 =?us-ascii?Q?6jSVH2Ly2C0lif+sQafuGwC9SDQOgTBPR3roSjC9qYGr170PbRjKrgegdg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KPClaPXo+GOLhsDsx2edfoVcQDatiAFuvYPgwYOngbdt9fdCcWSCk/RN7SYS?=
 =?us-ascii?Q?8gWm3kHu/MSi38cJjijm+FhepHr/7eZW73qfc85M7TNqCGLONoXaHw7tH1b3?=
 =?us-ascii?Q?9tpfj5/5TUIG3USlcQ0wDxk0s2fzlXKReeJqK+nu79VrzagjrOmbku24WbwN?=
 =?us-ascii?Q?a23BLLZ8GnEWWGXV4G7nf4SyXEUPd6lBMQZKbfMyH4HQBoGMpVI7nlPLBywA?=
 =?us-ascii?Q?939Pby/MI9ig3JHnNU4WYRNuoKGIndHcLMqjEDVXE1b2OYV/K9Qt047j20mS?=
 =?us-ascii?Q?rwc5341pGTuLwSjzYUGI9Bucx94E41Y5cPSmjeGfhNFsAJu1gCXuWhTOnFPD?=
 =?us-ascii?Q?eWt/0z+bfPUm8nD3zMFIi0RqTIwsrO+IY9QYx4lQOf6HoFCUbpv1qxwgmpzs?=
 =?us-ascii?Q?2ixFuX5JMQ9vcHAnLYvog/2mVi6aN40HZ4qjC3hGUqg1FUJCsS8Q88pd0WZD?=
 =?us-ascii?Q?ThVLrOH6HwB0AJtk7UIKF9o3D37w2iDM0xKd5Nx2lO4XsQpZN1+4/xCDifTo?=
 =?us-ascii?Q?5zObMzPdlZ7/afaUbQJHIYtTfDfUbnb/9Rbm5JiAGJhEJY7g0PhJXZ8pNoAL?=
 =?us-ascii?Q?ksCNjpgjnw9ymzVF9MBfsPWMoxHGCec1NKjlHvqaRC7vIYSU6LIM8nlj+AmZ?=
 =?us-ascii?Q?ViHCWyZWZ9XHWDXkl7FAOcWICs5kCu5pOJrKH7PF+O/ZUs0Xep+YvYxtPlWc?=
 =?us-ascii?Q?FWIjCnzd8lMw7bNKxrYrXlZ/OUP9FdBi6NOiK8xn4CYnBL6HflUUXZBTqNFM?=
 =?us-ascii?Q?I9zYkjX8DqYN89u+sdPyfTnCgfcNBqrAKnp2qdh27Caz/9JqbUZ/rN8XFxDy?=
 =?us-ascii?Q?6dNAg751S5tgQFXUgAvepZILpKRdUxJuQ1PByJQ1vbbgxh2rX8wXXtVI9M2S?=
 =?us-ascii?Q?48kXNAk1N03rwFveZahg+bGrPacLBtcFHEloyLO4mbzbPzQMFPeN11eZXloA?=
 =?us-ascii?Q?vCCYdM5rbJQILV2V3RuBcmaERlsnzQK6qnO8/QW3DS1tmvw46fcDr/2c6Aia?=
 =?us-ascii?Q?GuzpylQqws30A3JNrCAfF7kPiNTuGH7LBcxh+AW8n/1Ho6CBrhSPAOek3KyL?=
 =?us-ascii?Q?VvdyzJnyBaV29NniDmBRZFajsnV/R220R81YeneKfgWkfrzCLgM9IBYy+zWQ?=
 =?us-ascii?Q?/xEwbM7VIyzeYt/NTiFBrh2M03LltRc8Rlt5V68SRk3BotSbiK+q5gN9QeE7?=
 =?us-ascii?Q?BRlcyzQgcQO/LbxHHVHm9vEoCB6joLsLpS8VkXSqsKrcMy+Ps1emZcUS/gtP?=
 =?us-ascii?Q?N4qEhlMPHVGQmtUMFsVV0ZaT59sdFmi539ZVYuvFhSkcIjCg80QNtq4KUYAl?=
 =?us-ascii?Q?MpRekroJmU20bB+lzlwk8OW8eWr4m+KfwHbi3TkhdkPUCe+71TXiMYVJCHjt?=
 =?us-ascii?Q?VvBuGpXoqJ6LSAyMb7v+MtBYxytvjxfOkFDh44+2hkQap9n6SKblPm4Y0Uhp?=
 =?us-ascii?Q?c2dKP0QxdxpwyXDY9JkWUTzrvStSjHfbygh3E3upvBnCVerKf0v/bHMyanzJ?=
 =?us-ascii?Q?/biU0PQ06TQNb+w/qkByREM1N/4wj67JdFBCOBYJDcb2ADrzcavSi4FoSkRp?=
 =?us-ascii?Q?uLqw8jQ5PWMFqUw0/pcaZYBFMj1WZXL4Kg5pG59JcynBWOW6Awj90bnmIWiz?=
 =?us-ascii?Q?YTQs225k73yPpSBgG2XBfIVUlRib5M4QXTFUax2eK8RGFeh5GaHQKBmFUJbQ?=
 =?us-ascii?Q?0OGog29lEVZl9hf0Kh4FhZihixtlW6rC0wQ4I1KAvfAGICqe?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca70cf60-149f-4460-a193-08de52036bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 17:52:58.0689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZEVqrXZ/ePN9G80C+w/q4oLltE+MWGN/5puNumakB4frUi7ldOSsIuJzau5j5GGq5lSOttFn0z7BUwNQ44BTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5373

> > @@ -1154,6 +1154,7 @@ static void storvsc_on_io_completion(struct
> > storvsc_device *stor_device,
> >
> >  	if ((stor_pkt->vm_srb.cdb[0] =3D=3D INQUIRY) ||
> >  	   (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE) ||
> > +	   (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE_10) ||
> >  	   (stor_pkt->vm_srb.cdb[0] =3D=3D MAINTENANCE_IN &&
> >  	   hv_dev_is_fc(device))) {
> >  		vstor_packet->vm_srb.scsi_status =3D 0;
>=20
> There's a code comment above this "if" statement that describes the situa=
tion.
> The comment specifically lists INQUIRY, MODE_SENSE, and
> MAINTENANCE_IN. For consistency, it should be updated to include
> MODE_SENSE_10.
>=20
> With the comment updated,
>=20
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Will send v2, thank you.

Long

