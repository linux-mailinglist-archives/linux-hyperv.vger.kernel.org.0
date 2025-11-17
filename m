Return-Path: <linux-hyperv+bounces-7647-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C5C66206
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 21:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8FAE4ED884
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94A934B400;
	Mon, 17 Nov 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GBudYLF8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022140.outbound.protection.outlook.com [40.107.209.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398D34B1AB;
	Mon, 17 Nov 2025 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411994; cv=fail; b=cx2ybnBiif8TMVybAt90kSc/TQUoctOlX9ZIbJD5d1O98dacYlIz51x4q0BngT5XRTw4nX62958CyK6P+zwq8FX2peIt09FVCkDOvKD5MdsdDT2l4HgxmzlNF8Vo7IvEd3PBViohbmYlc5gnHctYoKRmZqJQgXsdunQZri6AL/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411994; c=relaxed/simple;
	bh=Tfx1c5j0rt/SoR3Ss06u8UbWYH4sr8yS6F2V2zvUFxM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VNPAhGB2MzQC2hsKSYus3whFznZrlbQ5+ZRS2FVgtEmToRvMN99ZP/uHM/Mwwx8jYJIwgX7JYGFAiDn+lmpkc2rmuH18cZxvGZoUT3aSTzBpEo61IHpCMBjvVdwxI+DCeSCGxtRVET8ekTP3q7IcJM0fqIejIkoPucfczmOH6OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GBudYLF8; arc=fail smtp.client-ip=40.107.209.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnjfiTPHM4cjJtdPGlz1n82ffHCRxbbt9P7vA4KtR8hiuo1pA11yq+E8pwLH0d8P6wAMR5DTcokZnjZoOi5VJvIW+0ztfQntPE5CgCH7P65cAHAnA7vgXLn8EgcMl8NN/m/R0xrSAjed+r/BCLyDVJ9rjcUKfSTUO2EZaiaXX3e5VQDeGu9+qQrPT6s03zgT5fmks/FrGCPw6xvxfVqoa2NOP/TEseA3OVm7M2EgPC4fyoJTmvEz68B7aI91JuRcAhe7PDOOWKK6azlK7t9JqM3L2W7VcM9WjvLSnekJ7x9cd+Q9DhoUVD2Ev6BYCPqjMp9jtWar7WtxqvabRh9J+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM2/ca7nPA7hyklUTXC+Q/sJX6cfyL6XoS1bNaDL1e0=;
 b=UEGEn85Y014x1YPTymAWbBczrMz8i3mHPbykqG2vZhqSiqcg61atXlFFsI3Rhj4ut2vMn0FAQHXuZp3CAIov82vxpuenfbEeaDV/uTPRPetjXqORd1MTG+G6sF4aRufFHOkNbqed9ChemHp3EtxcbyXlSWD94PXLBDV3PVA7mULqBnOwKgltILk4tOSX0ws6+avUcoQs+J6uey2Y4gBX9q/mgMAs+57gKv+hh0aceHIZDzCLVNVpL3hXUhSc+lkIpFJj2Rzg7kEDshpDYWgN3/dM6kb9kvisR76Gv/FF6o9tKj5agD65TdOMzYR0/G1mkgIoSHu7MgWRs4bhmJaHKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fM2/ca7nPA7hyklUTXC+Q/sJX6cfyL6XoS1bNaDL1e0=;
 b=GBudYLF8aqxoL3ZL6BgX6vGPUwWEPS0jZQztFFFq0pkvUXI3WWVm0okvNS6G9g5j2t8xrdW3Qcwt7PUEVBeYsqIKVzoG3a2/Pg13d5oao+GSCj8yQ+4UzmGmnS5GYM5bg32jRURrKwjto4DH/OClhZkHOC3gXyhHWYythGhMtz0=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS4PR21MB6816.namprd21.prod.outlook.com (2603:10b6:8:2ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.7; Mon, 17 Nov
 2025 20:39:49 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%6]) with mapi id 15.20.9366.001; Mon, 17 Nov 2025
 20:39:49 +0000
From: Long Li <longli@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "longli@linux.microsoft.com"
	<longli@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [patch net-next] net: mana: Handle hardware reset events when
 probing the device
Thread-Topic: [patch net-next] net: mana: Handle hardware reset events when
 probing the device
Thread-Index: AQHcVdeZQpVVnwuacEu+6Wtr86jRZLT1goEAgAHV0MA=
Date: Mon, 17 Nov 2025 20:39:48 +0000
Message-ID:
 <DS3PR21MB5735AB4B4D1629B6D375EF72CEC9A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1763173729-28430-1-git-send-email-longli@linux.microsoft.com>
 <SA3PR21MB3867695C1B6C975ADFDE635BCAC8A@SA3PR21MB3867.namprd21.prod.outlook.com>
In-Reply-To:
 <SA3PR21MB3867695C1B6C975ADFDE635BCAC8A@SA3PR21MB3867.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e9f0834-7ceb-4fc9-9067-2b03ca083e03;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-11-16T16:14:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS4PR21MB6816:EE_
x-ms-office365-filtering-correlation-id: b17e6054-ab07-4eac-39c2-08de261973ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?d7cdhV2DicKWHYaKLUWW9V5pSw0TTLV3ayCR0m6dAUDJHMAtjWfhyjC4Wp/e?=
 =?us-ascii?Q?lVj7xfS0S1dENToq+Xtesbi45oZjro8tmb4BZaPZ0EonyrSiJtpIEZXtiReR?=
 =?us-ascii?Q?+zV1Liw7YRd0PHfI9UA6un7twUsSHfRdrUVmlSCVCl++Eu+VHj1wlywbHyiC?=
 =?us-ascii?Q?kt37S0vy64huSEwrtbogkvm0/ehc9IOuo5BxzDrcP0fVUwuZ1t20gkYOL/Gd?=
 =?us-ascii?Q?0E0p9GqGSI7/NtR/5T2PeS2m/c6Z+jZnXHpykxdV03GAn0LmOWTHNbkrGYFQ?=
 =?us-ascii?Q?UW10tqCmIP7ljhDd8NiHE2M8CTLG9zgbRiohLuG92uIQ+TAX9ei8acHOCT4I?=
 =?us-ascii?Q?63v1mCd5FHuBZRAZ+iRnd/EeUHJDyr8RX6Dzp2FHbYB+HY7cmdB6/d/TZW0D?=
 =?us-ascii?Q?E+6YH7jLg/Fm5gC6re43PwB5cIhmFITWbmbi0JI/+Kf5KPugqzW4Uk9DuHpb?=
 =?us-ascii?Q?ovI0hWLRyCrSs8rZi9jL41YjubLQeJ0JTXZr2+kcL6FRERBtMJalCJd/GaIA?=
 =?us-ascii?Q?vm72cgZc//rqAUVsxNPYzla7+d+k/GHdRIB0d2YF9Iu7s8lytNEWrL4ofl/Q?=
 =?us-ascii?Q?mri8+pE5N8YxlHhWI8MlWYe5iZLqTCPL8PpR4mfpxLZVRllhM0iJTa9ME4oy?=
 =?us-ascii?Q?4EWpGmsTt/IO7jowf5kWi1BnjKyjnnCwGX0pbzsPgLgDHIBVEBUAfP2s58xd?=
 =?us-ascii?Q?rFZeWukfOXbAJOAn/wUngaPabfctbGJwMkvdkM+DsKAukSt1o9ybwf2PcUTN?=
 =?us-ascii?Q?AoVrOE4QQM+hDmYRTfiH66vUzDN8/9mgsIGy5SkKFuDXCov6xpgMBsSXvuE6?=
 =?us-ascii?Q?0ss8haqIYMCX3xbxmki/QuWEFjrhGOHA5TmRJru91FRni5lLCpUp4h1VUXBv?=
 =?us-ascii?Q?c4NrfQ8jMqs4s6OImJcvN1qaa1SQ+Cyy7sgztxOh3FekuphQy/h6Km1YWMPb?=
 =?us-ascii?Q?L8FdfT96Sc/sb+bD6jtuTzzDPyYzff2NtaZOJyKtTP0DM2Q5Pz8uZ6FnIkE8?=
 =?us-ascii?Q?6BZ0er39YYWJme37cYb/h3c4HSUQNBu39CFcfWUfmfikxDUiXUvv3BFLI7U7?=
 =?us-ascii?Q?Yv/4VctHElRB2RFmxXQl6C+fpnQG5Ymg7AEa0Mu2vfwQ1TXpOrZbmMTEZZKw?=
 =?us-ascii?Q?GqhdGm9BIX7nc6DkI2i6MuuY/zyKtTD+yEN2DGfVRfl/HL4gYzvHAEgN/8G3?=
 =?us-ascii?Q?mqCOD+o7LjoDROTjbr3+hzyGfn/DN3QLjxV9x4Wkwps+efSNyUXuHKIV2qLt?=
 =?us-ascii?Q?kyQz21kLauneegHmanI6t77yaU3YscMTA7nuBJOP266RNZGCegjjKbKrG28I?=
 =?us-ascii?Q?1NUw7Zx3h9o1CF2S9hc3bDPS4b9fjVAmgIGEwLb4hfXvD+MvUIEBu6hAIFQJ?=
 =?us-ascii?Q?H9N099hEM8JYHiLGIrO7xWGu4ijaDZ2ypQ9F22t7ChiRxf+uQurI4BoEqb5h?=
 =?us-ascii?Q?0abw8TZgsZiWNsv5ZREYo7mKhNvhRmU4BYLlbasRV73A8ADzhVeRcYTPaAs6?=
 =?us-ascii?Q?OYERZ7lGUaqMKv2cZrfJrlVGq94IXVS8+sLifwU1nejKugxv61p7oTqjbQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZkbDJUtuU4uKi6ieXVf2YkXm30MfIV8v9ZM+bQzWR5qo8mDhAzuW5lLtKWYb?=
 =?us-ascii?Q?elUrbZy4ouq5SIJD6qYBSoqPrBLDVub1nK6NNwrDYYSsrXMNt5KAqC6J1BP+?=
 =?us-ascii?Q?gPW4zXUG/AktdytsPkZjFqfCikIM0v3kPKr2EJ4XgLjjjt6Jb+3+cqbeJF+E?=
 =?us-ascii?Q?IP/RYqW2hKKkqgYQO/4swjgbyPRCBcqRNqaPLijy0IoSQKoIaO6463B9ojFh?=
 =?us-ascii?Q?9Ay3phr91EFSerr7uoMtxuiQo6C+IzdOdPxyvjtfPksvWRhrERXGZqrSc1UY?=
 =?us-ascii?Q?vajWivauVY+1hP2gXkKaKYI8399HgZcZTI6fWma6tuErMPYdzl7zzfdGz9u7?=
 =?us-ascii?Q?F9gGXbFts9xJhRVKrPAHEJEeiCQgKujKjGQXhNZxeyl/n6CBNfnmU9gJsPa4?=
 =?us-ascii?Q?o5LKE9c89DmGMkFAh27yUACasaO/zCaAphkXWiWZbX+r2ZSPgZmL+Zk4aS7M?=
 =?us-ascii?Q?Z/MVOj4xkKIjMzK1uXbWRScuTcX/TXcptM9HX2MmzqIqcjXqz1uhxBingSki?=
 =?us-ascii?Q?n7qHXyPC+shumvE7vEt3BioNyk7mc8YBUzuvlgm5ayHcJHF1BVdpnSXGtDfY?=
 =?us-ascii?Q?TZJfyvCxnPP+/eUT3R+eEpKxkyMg2jmKk99lzabVOeWUX7WZY5UXkYNO9aeS?=
 =?us-ascii?Q?xZaUTQnBleoB2qCLnn0WX62M8rZz2O9AtiFNB0Cgky7A19QozEaiWoOlEKTB?=
 =?us-ascii?Q?OlT3ozqNosHTr8AfTKwv3tvRQJZ62zsKda7topgEM3RVqcAZAPpItWqb7W3V?=
 =?us-ascii?Q?C0G6SmL74cAnyEzwerAToX8TKHJEenkCJ3wYW3d0+lKUtNeboPic0x34xcbw?=
 =?us-ascii?Q?Xyy9kDzPhUNIiYvJRc9uz0hqUJ82ZkDlmwxvDAQ77uuGDbdMqYn9u3BdbZs1?=
 =?us-ascii?Q?FeK1gLWKMTpGA/FaHOBuf9/Dywwe1tkaMSCbi+RjU2+lx6EPgIHfDdbuZd8l?=
 =?us-ascii?Q?/PWW/ZqIeixWJJLsHNYh5XdHLjyVaT8psLex4vQPpIrhARnt4gDI5jJu0Fey?=
 =?us-ascii?Q?HQopr5uRPf6MtDJKPFpEwqq89fpVF9lU1xwXLW1/m6jtFwT2OH5n/eAkksu+?=
 =?us-ascii?Q?u/GC3iEqV/gXE2kYTMGbJjq4fWPRi6MmZjUS+nbiGVcCuILKgYpHcrMu7B5m?=
 =?us-ascii?Q?thxP0LA3nm4oxplMJIYb56QLquuadhoSLFDn1n1QCld/AGLwhCw2JNaBDIxX?=
 =?us-ascii?Q?DfXuL2RO93mUkI7PsftsjMnxsErDGOzRWMfs2gQfS18BO1UILHZ4Ur33SKSA?=
 =?us-ascii?Q?TjR4cMJFb8odu5Dje9eEJ4MOByeuI95DCrXzAJV7zdjt6eawX6z08Dcw5Lap?=
 =?us-ascii?Q?lIpICHJG78dQWhszWeV1ljEZoHzRH1Lb2ceunLZYd0xtl4/ZyedNQ3mb2Hmq?=
 =?us-ascii?Q?n1oAnMO1nQe6ZnUsZuv6KxmkbpVBN2Fy2JDIHJuYYffwBCnWo/7GLRTCN69K?=
 =?us-ascii?Q?brMwk7NLw5S+J3fqz+uetE3cEsvSGIZAX0s7VfqG+6Ov4EBtylhEoAk1SVV0?=
 =?us-ascii?Q?KbLR0r7KXlJydkRdfLpfdzz05HaTA4URWsIYE1WAMSulm6hYwMA9arWLYM+7?=
 =?us-ascii?Q?IFpr/nQc6+Iso5auPas=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b17e6054-ab07-4eac-39c2-08de261973ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 20:39:48.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYmRDbaPWHwrZHI7eOBRLFTy/TRZVzQC2mxpA4aY+TP5LZScosyB0wdutq7I/+poBAG8CCdGKRy7s6hESzKa/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR21MB6816

> Subject: RE: [patch net-next] net: mana: Handle hardware reset events whe=
n
> probing the device
>=20
>=20
>=20
> > -----Original Message-----
> > From: longli@linux.microsoft.com <longli@linux.microsoft.com>
> > Sent: Friday, November 14, 2025 9:29 PM
> > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui
> > <DECUI@microsoft.com>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo
> > Abeni <pabeni@redhat.com>; Shradha Gupta
> > <shradhagupta@linux.microsoft.com>;
> > Simon Horman <horms@kernel.org>; Konstantin Taranov
> > <kotaranov@microsoft.com>; Souradeep Chakrabarti
> > <schakrabarti@linux.microsoft.com>; Erick Archer
> > <erick.archer@outlook.com>; linux-hyperv@vger.kernel.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > rdma@vger.kernel.org
> > Cc: Long Li <longli@microsoft.com>
> > Subject: [patch net-next] net: mana: Handle hardware reset events when
> > probing the device
> >
> > From: Long Li <longli@microsoft.com>
> >
> > When MANA is being probed, it's possible that hardware is in recovery
> > mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC
> in the
> > middle of the probe. Detect such condition and go through the recovery
> > service procedure.
> >
> > Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 131 +++++++++++++++-
> --
> >  include/net/mana/gdma.h                       |   9 +-
> >  2 files changed, 122 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index effe0a2f207a..1d9c2beb22b2 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -15,6 +15,12 @@
> >
> >  struct dentry *mana_debugfs_root;
> >
> > +static struct mana_serv_delayed_work {
> > +	struct delayed_work work;
> > +	struct pci_dev *pdev;
> > +	enum gdma_eqe_type type;
> > +} mns_delayed_wk;
> > +
> >  static u32 mana_gd_r32(struct gdma_context *g, u64 offset)  {
> >  	return readl(g->bar0_va + offset);
> > @@ -387,6 +393,25 @@ EXPORT_SYMBOL_NS(mana_gd_ring_cq,
> "NET_MANA");
> >
> >  #define MANA_SERVICE_PERIOD 10
> >
> > +static void mana_serv_rescan(struct pci_dev *pdev) {
> > +	struct pci_bus *parent;
> > +
> > +	pci_lock_rescan_remove();
> > +
> > +	parent =3D pdev->bus;
> > +	if (!parent) {
> > +		dev_err(&pdev->dev, "MANA service: no parent bus\n");
> > +		goto out;
> > +	}
> > +
> > +	pci_stop_and_remove_bus_device(pdev);
> > +	pci_rescan_bus(parent);
> > +
> > +out:
> > +	pci_unlock_rescan_remove();
> > +}
> > +
> >  static void mana_serv_fpga(struct pci_dev *pdev)  {
> >  	struct pci_bus *bus, *parent;
> > @@ -419,9 +444,12 @@ static void mana_serv_reset(struct pci_dev *pdev)
> > {
> >  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> >  	struct hw_channel_context *hwc;
> > +	int ret;
> >
> >  	if (!gc) {
> > -		dev_err(&pdev->dev, "MANA service: no GC\n");
> > +		/* Perform PCI rescan on device if GC is not set up */
> > +		dev_err(&pdev->dev, "MANA service: GC not setup,
> > rescanning\n");
> > +		mana_serv_rescan(pdev);
> >  		return;
> >  	}
> >
> > @@ -440,9 +468,18 @@ static void mana_serv_reset(struct pci_dev *pdev)
> >
> >  	msleep(MANA_SERVICE_PERIOD * 1000);
> >
> > -	mana_gd_resume(pdev);
> > +	ret =3D mana_gd_resume(pdev);
> > +	if (ret =3D=3D -ETIMEDOUT || ret =3D=3D -EPROTO) {
> > +		/* Perform PCI rescan on device if we failed on HWC */
> > +		dev_err(&pdev->dev, "MANA service: resume failed,
> > rescanning\n");
> > +		mana_serv_rescan(pdev);
> > +		goto out;
> > +	}
> >
> > -	dev_info(&pdev->dev, "MANA reset cycle completed\n");
> > +	if (ret)
> > +		dev_info(&pdev->dev, "MANA reset cycle failed err %d\n",
> ret);
> > +	else
> > +		dev_info(&pdev->dev, "MANA reset cycle completed\n");
> >
> >  out:
> >  	gc->in_service =3D false;
> > @@ -454,18 +491,9 @@ struct mana_serv_work {
> >  	enum gdma_eqe_type type;
> >  };
> >
> > -static void mana_serv_func(struct work_struct *w)
> > +static void mana_do_service(enum gdma_eqe_type type, struct pci_dev
> > *pdev)
> >  {
> > -	struct mana_serv_work *mns_wk;
> > -	struct pci_dev *pdev;
> > -
> > -	mns_wk =3D container_of(w, struct mana_serv_work, serv_work);
> > -	pdev =3D mns_wk->pdev;
> > -
> > -	if (!pdev)
> > -		goto out;
> > -
> > -	switch (mns_wk->type) {
> > +	switch (type) {
> >  	case GDMA_EQE_HWC_FPGA_RECONFIG:
> >  		mana_serv_fpga(pdev);
> >  		break;
> > @@ -475,12 +503,36 @@ static void mana_serv_func(struct work_struct
> *w)
> >  		break;
> >
> >  	default:
> > -		dev_err(&pdev->dev, "MANA service: unknown type %d\n",
> > -			mns_wk->type);
> > +		dev_err(&pdev->dev, "MANA service: unknown type %d\n",
> type);
> >  		break;
> >  	}
> > +}
> > +
> > +static void mana_serv_delayed_func(struct work_struct *w) {
> > +	struct mana_serv_delayed_work *dwork;
> > +	struct pci_dev *pdev;
> > +
> > +	dwork =3D container_of(w, struct mana_serv_delayed_work,
> work.work);
> > +	pdev =3D dwork->pdev;
> > +
> > +	if (pdev)
> > +		mana_do_service(dwork->type, pdev);
> > +
> > +	pci_dev_put(pdev);
> > +}
> > +
> > +static void mana_serv_func(struct work_struct *w) {
> > +	struct mana_serv_work *mns_wk;
> > +	struct pci_dev *pdev;
> > +
> > +	mns_wk =3D container_of(w, struct mana_serv_work, serv_work);
> > +	pdev =3D mns_wk->pdev;
> > +
> > +	if (pdev)
> > +		mana_do_service(mns_wk->type, pdev);
> >
> > -out:
> >  	pci_dev_put(pdev);
> >  	kfree(mns_wk);
> >  	module_put(THIS_MODULE);
> > @@ -541,6 +593,17 @@ static void mana_gd_process_eqe(struct
> gdma_queue
> > *eq)
> >  	case GDMA_EQE_HWC_RESET_REQUEST:
> >  		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
> >
> > +		if (atomic_inc_return(&gc->in_probe) =3D=3D 1) {
>=20
> Since we don't care about how many times it entered probe/service,
> test_and_set_bit() should be sufficient here.
>=20
> > +			/*
> > +			 * Device is in probe and we received an hardware
> reset
> > +			 * event, probe() will detect that "in_probe" has
> > +			 * changed and perform service procedure.
> > +			 */
> > +			dev_info(gc->dev,
> > +				 "Service is to be processed in probe\n");
> > +			break;
> > +		}
> > +
> >  		if (gc->in_service) {
> >  			dev_info(gc->dev, "Already in service\n");
> >  			break;
> > @@ -1930,6 +1993,8 @@ static int mana_gd_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >  		gc->mana_pci_debugfs =3D
> debugfs_create_dir(pci_slot_name(pdev-
> > >slot),
> >
> mana_debugfs_root);
> >
> > +	atomic_set(&gc->in_probe, 0);
> > +
> >  	err =3D mana_gd_setup(pdev);
> >  	if (err)
> >  		goto unmap_bar;
> > @@ -1942,8 +2007,19 @@ static int mana_gd_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >  	if (err)
> >  		goto cleanup_mana;
> >
> > +	/*
> > +	 * If a hardware reset event has occurred over HWC during probe,
> > +	 * rollback and perform hardware reset procedure.
> > +	 */
> > +	if (atomic_inc_return(&gc->in_probe) > 1) {
> > +		err =3D -EPROTO;
> > +		goto cleanup_mana_rdma;
> > +	}
> > +
> >  	return 0;
> >
> > +cleanup_mana_rdma:
> > +	mana_rdma_remove(&gc->mana_ib);
> >  cleanup_mana:
> >  	mana_remove(&gc->mana, false);
> >  cleanup_gd:
> > @@ -1967,6 +2043,25 @@ static int mana_gd_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >  disable_dev:
> >  	pci_disable_device(pdev);
> >  	dev_err(&pdev->dev, "gdma probe failed: err =3D %d\n", err);
> > +
> > +	/*
> > +	 * Hardware could be in recovery mode and the HWC returns
> TIMEDOUT
> > or
> > +	 * EPROTO from mana_gd_setup(), mana_probe() or
> mana_rdma_probe(),
> > or
> > +	 * we received a hardware reset event over HWC interrupt. In this
> > case,
> > +	 * perform the device recovery procedure after
> MANA_SERVICE_PERIOD
> > +	 * seconds.
> > +	 */
> > +	if (err =3D=3D -ETIMEDOUT || err =3D=3D -EPROTO) {
> > +		dev_info(&pdev->dev, "Start MANA recovery mode\n");
> > +
> > +		mns_delayed_wk.pdev =3D pci_dev_get(pdev);
> > +		mns_delayed_wk.type =3D GDMA_EQE_HWC_RESET_REQUEST;
> > +
> > +		INIT_DELAYED_WORK(&mns_delayed_wk.work,
> > mana_serv_delayed_func);
>=20
> To avoid INIT_DELAYED_WORK potentially multiple times this should be in t=
he
> mana_driver_init()
>=20
> > +		schedule_delayed_work(&mns_delayed_wk.work,
> > +				      secs_to_jiffies(MANA_SERVICE_PERIOD));
> > +	}
> > +
> >  	return err;
> >  }
> >
> > @@ -2084,6 +2179,8 @@ static int __init mana_driver_init(void)
> >
> >  static void __exit mana_driver_exit(void)  {
> > +	cancel_delayed_work_sync(&mns_delayed_wk.work);
>=20
> I think we should call disable_delayed_work_sync() to prevent the work
> scheduled again after this line.

Thank you. I will send v2 to address all the comments and support multiple =
PCI devices in BM mode.

Long

