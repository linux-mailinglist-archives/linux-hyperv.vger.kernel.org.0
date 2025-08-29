Return-Path: <linux-hyperv+bounces-6667-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA6B3BD4F
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F4E566DC1
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3123148A0;
	Fri, 29 Aug 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L+nPQoNr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022117.outbound.protection.outlook.com [40.107.209.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C72877FC;
	Fri, 29 Aug 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477054; cv=fail; b=Xbv2vM0zeOXdbo4VNHLtO1wpsSUjP7EHUmgTGA82pjFCN4oEDw0ESqxxz8YUAn93UlPA+qTSidQR/f54dPep6kcYqFAMk2KJ+zpZrPKwkGACXeCpiVgB7i4ewyectYKJrHC1BQUPYQ/5MyHTlWalBpPV+375xiAPJnj+FAlbenY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477054; c=relaxed/simple;
	bh=g6qFsF/CUlrDQsc4oLLw3WC6xLxd18VnPIXXF7uLPt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pv16mGgTAzasNoZ7sevr+Ql1+1lQCX98eID9EuZfrMH3DRYGXHzTCs1r3J0jsZHXlP7/lOzsHabb57cxyFZErr3XUasxfx+89G8hyBJeeutc1rp09tHZEfYUHk4vV+ZXqImA4rr7Oen5uFbV6Oooytsbf6q49QMxKQ4Z1noKQxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=L+nPQoNr; arc=fail smtp.client-ip=40.107.209.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxK7nY4jXC0NtFq6MvpSvajerUw47fnChDyOTY7PEAs0/HhPVxu97ZiNRDEtwnDbzSnhh4hM0fMxy7vWLG3JI8wvrU5TLZRVe9cy/GG67upPoRRe+/xMD31mz/I1SPASXihQ0asq9qdvqhvDRYFbP25yP4kepUT+BHQaUD88agFqFT/EPThwrWGZybesPeQz3bkBkru1OXU0SCe1FlqovWW0fmNopT5GycnITDYl57KRfYzTdINtRDmU+yWz2AXdPkhKXDdUZ+83zpuDRs8pW+3Xt+g9cyLvUj+fZsrYqZTN+FJ0cL1h1b6t5qtsNfTV4wk4PBv0n9e5RZLrrjWAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU2/9kZxOXSqmREAjY/kZh7+Fcu2yIl3y/uuRkYZWS4=;
 b=TAj1h4hyo7slEM6WiyvSdgCKK3zdTgat/L9MCAX2PwWqRmNIJ8lOvV9z1IzleFOIqr79rNaTf9GQbAeirEd8E19HZ7ILidVIf/NL0aVQSyLxuzM4CmZePhWuSwWrNayKAvnq74rCndde5ie9JBs3nEzyngvgQtErWxUei2jz3bREI8QDb957Ku3IiHSNhVaWIcUq3Q0H+sSszBdo9dL8Qh0SKP3H2uRn0kkW1Ze/w8vvheCqjtsAtXQ9/Y0HxYGdXGvY/aSJkZ9oYS3an7HfEz8KnZ96uuSOPWWxtG6GhG6BQe5v/F16O1KLcFD/jOq28Md+nqidotuq68sAfMyhiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uU2/9kZxOXSqmREAjY/kZh7+Fcu2yIl3y/uuRkYZWS4=;
 b=L+nPQoNrDxIEuzrPfYSSGWQ5+W0bRO/gIaG76KvJFWhFM2Sm8zTn0nWgyBIhu33lLZWRsCLo7ZiXrDOovOF4je/r5/SHKauJCshjH4RGXZstkALS+gAYwmdZlgna1wDbOFd5UM/qyXSfgNDSMu3CbEtFajz3Ci25bXYE7J3nw5Y=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB4865.namprd21.prod.outlook.com (2603:10b6:8:299::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Fri, 29 Aug
 2025 14:17:30 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::ac75:c167:d3dd:5983%6]) with mapi id 15.20.9073.006; Fri, 29 Aug 2025
 14:17:30 +0000
From: Long Li <longli@microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley
	<mhklinux@outlook.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] uio_hv_generic: Let userspace take care of interrupt
 mask
Thread-Topic: [PATCH v2] uio_hv_generic: Let userspace take care of interrupt
 mask
Thread-Index: AQHcF9YhlUYVj3O6LE+KobLzRCjJ+rR5GRqA
Date: Fri, 29 Aug 2025 14:17:30 +0000
Message-ID:
 <DS3PR21MB573592E3AF6599D9DD751BFCCE3AA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20250828044200.492030-1-namjain@linux.microsoft.com>
In-Reply-To: <20250828044200.492030-1-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a7100f44-573d-467d-8d16-516516fefd37;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-08-29T05:18:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB4865:EE_
x-ms-office365-filtering-correlation-id: 6d296968-ca9e-45c0-3117-08dde706ca03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AdxVZz8yLNxO24/sgEw9SQ16yXvfzhNSEktP3tAVZsvxMb+ofdurmVdbKO?=
 =?iso-8859-1?Q?bAaGScGdIJtnYhbEo5Uf9YhSGpJJdPceq2CEq/iQ/u91NbKcwM2V1ZlJx/?=
 =?iso-8859-1?Q?d5rDgoSsZOw8rEEsxMt9a0FYB+hZtcdLZK+JspensqUR1SG37aBjj9XqKt?=
 =?iso-8859-1?Q?tCqXqa6pV2VZBsWhdiHxEIQSji4/1HvmNOIU+y5kOw6OasIkUkMm+NAqn9?=
 =?iso-8859-1?Q?hvBOEnnsjivQQ21t6CzvSGx89mbALwwZGxdAoKO5e569KOXLg3Wa3mmu9W?=
 =?iso-8859-1?Q?DhVePTLoQ+Y2icJnWuoqKJNambJ6F3C96n6aiCVTTUo6HVw6e4scDkA/9Q?=
 =?iso-8859-1?Q?io92davxAgy0BUIM7z+NyGwYG8upYbkGqqvUSXfSh3Zsr3V+Nbb+wES69L?=
 =?iso-8859-1?Q?Y6gK6QqpYBLF9yTso2K7I+eZZxvu6RQJuTy21XDLpiJydLrHZx63RQcVds?=
 =?iso-8859-1?Q?fAKJDhWmhXhahVP/B7KkHRIMorCykf3p93Hcp1eWlgsBDyOU8veBj+G3XD?=
 =?iso-8859-1?Q?Mi4OQdRVkjr8op32TgjGf+d6kMMwoB+SxY/lRgw7W9b9H7I7plgB9z8EnC?=
 =?iso-8859-1?Q?5oodn2H6QtReSt3aEpR+yxrbp6lEYi0I7ajuBNSLfVgjfv60UgfJB3GTVn?=
 =?iso-8859-1?Q?EFr9maRKMEL5M9ldCiELjejcV+OYnnw92vmL6hSlF9+RCs4KaJEF5qAScO?=
 =?iso-8859-1?Q?hRQBH0T4Ug8zq4xyYmBvSI8uEJHiVX1Bm3ZTieZXT/NF2tSRLAFRTkGRb5?=
 =?iso-8859-1?Q?QMo/vUGxc8TZv1if3ER0FuphHiH9+XpkzYz1rOr0S469B3tYh9eybDZPG7?=
 =?iso-8859-1?Q?fBPFzMljWDAnPO3lMC14+y8LRCkRHmtspCKSfxy5mIPV+0+RdfVQ9DDhwM?=
 =?iso-8859-1?Q?x4fbJiciY8PC4DwGmoqjkCC9BHh+en1h3sPgdpkmjcUd7j+IVOjfUDdg9Z?=
 =?iso-8859-1?Q?iCBsWKJO2fdB4SD7VdzXpOwFXTtj8ys9WRXAnq5Me+IklQF2p5McPElZlJ?=
 =?iso-8859-1?Q?RFjzyg/9S9P7KGh/MZtk3tc75F02Hd2y1p1BP+fuT58AyndGbgGptwFJJf?=
 =?iso-8859-1?Q?29OcpvV+AYNvM5PpxqBmWaRdeF1jNTOD9irIdmTtogJJpoaWdZ26CicoJb?=
 =?iso-8859-1?Q?k8+3GdYiGcKOOTaGW/W7OV9C0xMFaO0U8vZleXj1U3Kzvc+Ux0EAu+H4BF?=
 =?iso-8859-1?Q?LUT9PHVVGR72+wING3L+wxCDFw9iMHW2s60+xdzYPVCaCxfDvLvRu+Lji2?=
 =?iso-8859-1?Q?ZZr73NgrsyhHdcf7MdIsFh7+90m4r+MI2UPMEDxZJJ/xKjyondN9PE/dJQ?=
 =?iso-8859-1?Q?mCpZfQ/Iyo2lR/pTVb5Rqang+hAEZQxxheq8jfCi0ph3e3vz/XFP7q/04U?=
 =?iso-8859-1?Q?jBllhDdt/b6bwEcNQTvtteoMsHoz3LWITP3sqi4HBqeLDfJaOl6U9sKMLG?=
 =?iso-8859-1?Q?z3qeUzEqOv/lerhz4MG/UAC9cURIY8Ik0Zq0TY+IcSAM7QUXD19NDKjJ4l?=
 =?iso-8859-1?Q?BWxpk1KO1gg+Jxi/FItuic+66IkFhjQzGrey3mgzzwSw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nll5EaIodgHUCgfp0+UlkhQt8M9r6qoB/3APfEvXsgRvuAti2iGCxgH+td?=
 =?iso-8859-1?Q?OyVmiStJL3jlueT1XTlbHeSes6UshZDakcsNZShTwfuHZGXQzQBMUmcS0L?=
 =?iso-8859-1?Q?uqJtGqWVd6K/ju3RmBXbovocuEs85LsGTvyCrtPTPh0mp5fKDt+teScY2w?=
 =?iso-8859-1?Q?Zpub2fju0KzS1+T78mCaFbKvOUthmVnlkU14fAuJep+xyCx/msrDcsXxsK?=
 =?iso-8859-1?Q?vKDxOMpyo6KkaCJ2egLEUTzYC892A5D0m7fKiBFO4aGGoZLWhcXjV6iRxz?=
 =?iso-8859-1?Q?+D2Kos3A1o9nVBphhfalzAyBeGTFJHKx/DpPIEnsoweaCUZTuBWbajgWG6?=
 =?iso-8859-1?Q?BVv/aTM39yLRUyNkMuENuHfjPWQRfi2xMUdTW5loyVNBh65VLMECbOXiZb?=
 =?iso-8859-1?Q?Xqfp1l+5by/D2YcZRIH5ps1oXTrBDTmmcSvcJXTjI6F9NBLxHeLx7Jrg6g?=
 =?iso-8859-1?Q?Ssqk4nIVsnfuPi3WC5LVQXodeUTDWapGKPLTm2ItlJ4dipeZJXlFDs4PTQ?=
 =?iso-8859-1?Q?ZTpSfE2y925ZHMdelvvlrh/78ZJCtD3gGNqLQaSpcxyuPPUJ+R1FGSWvg7?=
 =?iso-8859-1?Q?OkipitOxShr0AAsI8z8v1DaIrmBdO06iDSp3t0GpmIkox8hpzUbfqzo4HI?=
 =?iso-8859-1?Q?ZX1aEVr9dhg59PbXBR6O4E5QUs6ccuHzU2NPg/s94eZci4zkjkkTKOdiv9?=
 =?iso-8859-1?Q?TIHmag0MWBAmlVmHxRkjwCKVgNGK7EgmccElBIgAgGWkMeF2ywOhcQJ4mM?=
 =?iso-8859-1?Q?DTPYzRbRPwrIECSnb7kDPpr2XJghZTurpWQAR1C1WR1f5Xy+HwfjOwAqLF?=
 =?iso-8859-1?Q?MQBEH9Np+zc8aEF/uVAqkJpqXnTT7B/9idDt7HauxA5s2Y497zxhpUBMsL?=
 =?iso-8859-1?Q?pgjdNRhwn1q6Y7CxYMeLtyBT3ZjyXwxUNlF7OS2ZzNMX5iVAfDXVTNTe4r?=
 =?iso-8859-1?Q?cyJZ6Lla+NBTELEZZhTO2AnXH8nTQ8w5xy5fGEC1qEtHoq5xox/s6YhZNP?=
 =?iso-8859-1?Q?cvYQ2dZmTmkej5skmUx16Gb4nCdwJL2XCHVgpioK5W7BHbVueJ0uH+0CRI?=
 =?iso-8859-1?Q?tV5qA8LCpZsN2bHYtdYH9jrjgTkgZEdwoeopMUqMYvvVAbZ7PyVdThyU9L?=
 =?iso-8859-1?Q?NGnimKZLp+1gKr2/YnEev2G5ygtQcH6AwNK67pURg+scnPkR+6A2Lcqzdp?=
 =?iso-8859-1?Q?8UZpHITxpQyq3/myu48YwEW8tNOqX/rCMwVY0CnkcRJ/eE4mbxk2b4ha+D?=
 =?iso-8859-1?Q?pnvu7yLAVXoUUw9QXSxqNqTKON+P/V5tSmRbf2EQ38N7wHLffO1+QHVOHv?=
 =?iso-8859-1?Q?Alj3Air66MHwkBlTaJrywe9VUgpgGrJcG7SxwJ+wVoVR8b1TMdX+rTWRfR?=
 =?iso-8859-1?Q?oDz0PHDLWQzx7gs8vV3YMkAwAW18lcrhE/EjuyYcz99UiMYe9mAhjLCgEC?=
 =?iso-8859-1?Q?9ZI8DOcKCZDDTffDCqdQCxthjMQC7RsJQr70uP7edYIsG9AifOlRh298Gh?=
 =?iso-8859-1?Q?Sm/cG6QSWaeXNTpPVxBs9KNUy7SwSPZzg13ioYRrXiu/nyYIJSWRhN8UFC?=
 =?iso-8859-1?Q?FWUqMM+nhTl2DtL/R61Wrhp3XLC4/EE+YG0yZ5dxA6rxpN6yRT0DgAW7Uw?=
 =?iso-8859-1?Q?VQP3/Z4GL4lczicaQ1osUh0ubEq4brfgcv/0tZULh9WDQLPHrj1QBZUu7y?=
 =?iso-8859-1?Q?SS7u5NCO7QLYIMx7g05d9Mmc29W2OalL1Yiju+S7?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d296968-ca9e-45c0-3117-08dde706ca03
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 14:17:30.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRALpf02GVA8OudK5ugdkAI6cNolvlpCR9ab/PLP73dutccnYLJLc8WayapTbqyXIe9ny0GmutjBnZ0EQ3UYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB4865

> Subject: [PATCH v2] uio_hv_generic: Let userspace take care of interrupt =
mask
>=20
> Remove the logic to set interrupt mask by default in uio_hv_generic drive=
r as
> the interrupt mask value is supposed to be controlled completely by the u=
ser
> space. If the mask bit gets changed by the driver, concurrently with user=
 mode
> operating on the ring, the mask bit may be set when it is supposed to be =
clear,
> and the user-mode driver will miss an interrupt which will cause a hang.
>=20
> For eg- when the driver sets inbound ring buffer interrupt mask to 1, the=
 host
> does not interrupt the guest on the UIO VMBus channel.
> However, setting the mask does not prevent the host from putting a messag=
e
> in the inbound ring buffer.=A0So let's assume that happens, the host puts=
 a
> message into the ring buffer but does not interrupt.
>=20
> Subsequently, the user space code in the guest sets the inbound ring buff=
er
> interrupt mask to 0, saying "Hey, I'm ready for interrupts".
> User space code then calls pread() to wait for an interrupt.
> Then one of two things happens:
>=20
> * The host never sends another message. So the pread() waits forever.
> * The host does send another message. But because there's already a
>   message in the ring buffer, it doesn't generate an interrupt.
>   This is the correct behavior, because the host should only send an
>   interrupt when the inbound ring buffer transitions from empty to
>   not-empty. Adding an additional message to a ring buffer that is not
>   empty is not supposed to generate an interrupt on the guest.
>   Since the guest is waiting in pread() and not removing messages from
>   the ring buffer, the pread() waits forever.
>=20
> This could be easily reproduced in hv_fcopy_uio_daemon if we delay settin=
g
> interrupt mask to 0.
>=20
> Similarly if hv_uio_channel_cb() sets the interrupt_mask to 1, there's a =
race
> condition. Once user space empties the inbound ring buffer, but before us=
er
> space sets interrupt_mask to 0, the host could put another message in the=
 ring
> buffer but it wouldn't interrupt.
> Then the next pread() would hang.
>=20
> Fix these by removing all instances where interrupt_mask is changed, whil=
e
> keeping the one in set_event() unchanged to enable userspace control the
> interrupt mask by writing 0/1 to /dev/uioX.
>=20
> Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus"=
)
> Suggested-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> Changes since v1:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20250818064846.271294-1-
> namjain%40linux.microsoft.com%2F&data=3D05%7C02%7Clongli%40microsoft
> .com%7Cd254da4dfccd4050923f08dde5ed4153%7C72f988bf86f141af91a
> b2d7cd011db47%7C1%7C0%7C638919529361971491%7CUnknown%7CT
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJX
> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D75
> A%2BJu5gaUZhYuBXDZEyKBRgJlsnaUenzL3wFOngMnU%3D&reserved=3D0
> * Added Fixes and Cc stable tags.
> ---
>  drivers/uio/uio_hv_generic.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c =
index
> f19efad4d6f8..3f8e2e27697f 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -111,7 +111,6 @@ static void hv_uio_channel_cb(void *context)
>  	struct hv_device *hv_dev;
>  	struct hv_uio_private_data *pdata;
>=20
> -	chan->inbound.ring_buffer->interrupt_mask =3D 1;
>  	virt_mb();
>=20
>  	/*
> @@ -183,8 +182,6 @@ hv_uio_new_channel(struct vmbus_channel
> *new_sc)
>  		return;
>  	}
>=20
> -	/* Disable interrupts on sub channel */
> -	new_sc->inbound.ring_buffer->interrupt_mask =3D 1;
>  	set_channel_read_mode(new_sc, HV_CALL_ISR);
>  	ret =3D hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
>  	if (ret) {
> @@ -227,9 +224,7 @@ hv_uio_open(struct uio_info *info, struct inode
> *inode)
>=20
>  	ret =3D vmbus_connect_ring(dev->channel,
>  				 hv_uio_channel_cb, dev->channel);
> -	if (ret =3D=3D 0)
> -		dev->channel->inbound.ring_buffer->interrupt_mask =3D 1;
> -	else
> +	if (ret)
>  		atomic_dec(&pdata->refcnt);
>=20
>  	return ret;
> --
> 2.34.1


