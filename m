Return-Path: <linux-hyperv+bounces-3754-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451B4A19DF1
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 06:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C47C16B9DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2025 05:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD56198E8C;
	Thu, 23 Jan 2025 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CD75WkEK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020082.outbound.protection.outlook.com [40.93.198.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4890629;
	Thu, 23 Jan 2025 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737609542; cv=fail; b=t1RvrSU2vk6mnHypMHIPuFXYh6Wfaarkbef6VaO2IpDRK17kV6zCujZg0fnpKD5nqkVmk7tfApzyMjIhOGC6OiGmhfJJ6A5QeJ3nyUdiJ7rEiiHA6y5qGf9AhzAH+Y6kXK0cBuRdMAdhfgF0bXVeA592wgqxQS3J1xLZvIx3tMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737609542; c=relaxed/simple;
	bh=0hbOSL/NXpdzb8gTLP4DqxflKa/AYMkNXknVYa7/QxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r0lN//fiUHZ0cgnQbIYL/J26+vuPJMjPB4NrJatRuhkWZvdWuacgApkBnCp+7ZZ5HhwX3xJpX9z9ccJlLyZUfFr0ibQ92B88F2g2wT6T4MgYjd7qHSr+7NenrMIBtb9TAqa7jsA+D5s22S00RkiaL9xDJh5b33MT6zRMIIhPpNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CD75WkEK; arc=fail smtp.client-ip=40.93.198.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ0gwoX7Fk2SEVc/BGl5T0v5qBzIzesKmQmjC47NrdIASHIUeeoZjycRkYlMiL0rXsJEkqSP0a05wJGK1eppE5R/2gdkkv9xv97053OV9yrpkP1wqa7IvWGnSkrfnjf3YmB9P39yy7K8weow1vs/wfWbvb6S0VIzagSPT3fax1L549VmwgNR8eN0qa+pTKuEncATSo2opDPpSwgkMFDttkMny3sDaaEqQ+VIK46dkSvuqumazz1w+RKwIbw0EsAzbbYWU0EIlXbJ5rCdwamKY7cispC5XxprcEqdutbvBayQYFAqDxEZ0BWxSPmCdWtXdYPe+6W7LmEABSH1MB79Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSDwB7lAFGsdZQC72Wx81Eg/CchzPgkp1priiQ8lY7U=;
 b=oryfdr3ht5zBag7LaVy+WiYSOGzd7zIaZImtcnC4zxMO4coqUY3N6s0gb/O5Ayo43lyx3Jwt3+RCF8ZLj7nIZ+L1TYxPdXySIQvJlra+juQ+JoyxzrQnbt+CrnVrpgpySLCKixdRWcwkMPDe6IFns6OKU2CWylZU1HUxdzNxHEpzcAu1JN/m3L76Xypcdd9Nrv56Hg0pwJTwucqdnNQh852aK7MIrveTTPz3E56216QEOmns2AVtmmZXtyBr+HZV856hJeTnTa+WUBHDpspBDy8gUfZ18T+3pHuz+qVuPAmv4KcOFSmK/wcRuJZz43Ooi+kBFxdvJ8zMPDknEB8Kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSDwB7lAFGsdZQC72Wx81Eg/CchzPgkp1priiQ8lY7U=;
 b=CD75WkEKPBIqZ42h//wMbY5cqdsuXeatxJu/tI8GqQix7VZoqMukH9Y7cm2NYbNjhn4qR/dG1ALHyGXtA0fFwXHd0O6WfzZqKOqh0fKfICeAfunDbQAqBXwlCLcHPC99YfH8KY6kL0PPCkWnYYNsl9FUbn4lqMNQHstsDUR++bo=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4302.namprd21.prod.outlook.com (2603:10b6:806:418::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.7; Thu, 23 Jan
 2025 05:18:58 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%5]) with mapi id 15.20.8398.005; Thu, 23 Jan 2025
 05:18:58 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH rdma-next 02/13] RDMA/mana_ib: implement get_dma_mr
Thread-Topic: [PATCH rdma-next 02/13] RDMA/mana_ib: implement get_dma_mr
Thread-Index: AQHba2CWX6caf0bIak2bZYc+2IvRhrMj1crA
Date: Thu, 23 Jan 2025 05:18:58 +0000
Message-ID:
 <SA6PR21MB4231A81F9608E9072EDD4EE8CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-3-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1737394039-28772-3-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=50a0d8db-6421-4144-8772-945dd0cb651f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-01-23T05:18:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4302:EE_
x-ms-office365-filtering-correlation-id: b9b3a86e-77c6-45f2-04fe-08dd3b6d7094
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vXfW82GQNWyByC4lbCoT9wM8EmmUE/9Ip9SlidgskhNNVVAsIJB25Gj+H3/7?=
 =?us-ascii?Q?qaSpfoXqRDx7msaCEjqKgbRDhloDSBfbFcJBGeHBFGzoOnSMuSedgIdKWsQ9?=
 =?us-ascii?Q?5ahl2N0fP52XuBmws8oxu75cIonrcuCO6JBpmCpfq+I0m7ElHk81JUCqcIfb?=
 =?us-ascii?Q?HRcNGEoEnB19kaJPj/X9zOxbsXL74tb/EfZgtL6itunsFi59i7vaX//Q/HuQ?=
 =?us-ascii?Q?OAacdKPS7KYYaa1PRjpy+xYKuU/eWk/AGSySfixpD78OewrFDNXRp+waTh4K?=
 =?us-ascii?Q?K2UJWftIhPU9ew6HgVBdcUQYeUO4b8MqfQS+icB8uYSszCPqjvCKK2pZPevO?=
 =?us-ascii?Q?1/6+pUM4aP2FJr1QgiC/Ni3qYr0cgRJ0idMf0BcaoQivTnIh61LZ0fiiWl7K?=
 =?us-ascii?Q?NO1/f6i39Nht2yl2lA0SNuM9b9PzwvIBAUk4ouiHwZFevILt6AjKgT0pFN0i?=
 =?us-ascii?Q?Fd48BkRr3cuuS4tvDEtiJ48jur1OAe/0DY7pl8GHqUm0Y6JEZdb9AfrzOnV+?=
 =?us-ascii?Q?C//QhgQKC4D8sdvZpkkpjE6+2imj6HDM+SiTFzurYfSShMBPRoZfhyNEUJEd?=
 =?us-ascii?Q?vumqIJ6dwOckfaJBBc2plIST2kFDatLbcnYyVngO9jQFgEC5Wv5VJbnv/rVr?=
 =?us-ascii?Q?TXNFp28XrqfEhcnMhMKND5LiKOdgzxIRtnjonk5Pwx14DsMtlfxqmC9Mf8ld?=
 =?us-ascii?Q?uVASJYyjPugussrUqTNv3As1cFsfCaN698lT/EPlslVwyGenNHjXUbw8BO/V?=
 =?us-ascii?Q?EFvpi8ksXKxENIJakWr3WIRE1w01yyNNtRZAu3acmlPYI+sYwPwhzoH3+Jdy?=
 =?us-ascii?Q?7H4NyPJr41PwRw/o+8qQuQIk1mH6PmT7OIp8DhZszUNhmDCe7MOTdJuLgrq9?=
 =?us-ascii?Q?RdQt5OE7fUvKlLj+DeYiteZfY7KEQ6Gnzx66C62HC1RltW1hjkSmV2Sn51J2?=
 =?us-ascii?Q?+OWBvNx01RUiO2SfpXetNkSN//XPbkCPKk6FDSA9Pi+OayJVw1VKVIIhISM1?=
 =?us-ascii?Q?gPfJwlusn19CvCGFPJvq0Qtx1EKAYtRRO61IsdJ0788dEWC3kvYJ0SySth/w?=
 =?us-ascii?Q?pZ6FP9rsyLtL1lT+2kmWIDgHpgoasuE7wVdhtB60RiYdn5sWehOe3rLiqawN?=
 =?us-ascii?Q?H9/3EYgp7Hs3145TKUX3DThhW32JGfDao0ElC00QWRhnRyChrQJuvJMVUpug?=
 =?us-ascii?Q?khwOIOmiwJ7xDt+6JRneAT2/geS3H6Ohej4Jg6mh789C44njp2gjlgl+WXBX?=
 =?us-ascii?Q?V3ENt1Z6mHVX20g8QYXz+zx53p26D1gG6bLj26FkxiLHmszYapTvKuuEsIQZ?=
 =?us-ascii?Q?5LnMMg8Lal6fZbb0nCuBgoKZxMl+Hx0VvLWCmvsJCXCfpEBJT597T6S9o1rN?=
 =?us-ascii?Q?mNvS14i7MS03WJyWQL3Nz4fjGJlymhOzrP5luHyGI+2y5pyeUdt30J3U2Fju?=
 =?us-ascii?Q?avll1LTanFFA0avuox3IDr+GkC/xmKRvdYXcQOLw19WcE7IuZAjfag=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FY+wUuZ/XH5uhBYVX30N1LVWTux5kuOrd7E/mEOVrUeRLFzaJy6EZ0KvOB9R?=
 =?us-ascii?Q?oGLmAH7eQ0KO9ocX9le9s8Az0VfNKuNgMBdHPjGLmIVi60toqCg+u4dNc7Ft?=
 =?us-ascii?Q?h4i5oQmuVFMB718sfXUQmz+1183jpCAuTeQfySKq6mrJqKeqrRmZ04LIz3DO?=
 =?us-ascii?Q?31e3V+8V5hFw5pzT71NOPcFUn9A7/yseAC6srNq1hPEJV0nAnWPMgyucrY47?=
 =?us-ascii?Q?ZATR1tw1oI1QKOyLcCUsn73PKyobZSXnJmyM6QOKBkzx7A8SH2kYtPzQef08?=
 =?us-ascii?Q?g3LmGkOveysVMsO+4H1geoBOrsSEhxvWJZ8Pt7MQC18f0yaFJzIBDillv8Pm?=
 =?us-ascii?Q?GUwY+oqkhpwinV8IixWbIOQ517ciMUgeoBn37MSxac9q40+LnzEJCNJKvfXv?=
 =?us-ascii?Q?tW3xCFNQXgmTS40BK/QCtU5IWFImYP8ovjpdFCJEI3yPBlp33ycykyAhTLg3?=
 =?us-ascii?Q?mHkb4tbWwNfYyVnPL9gODzx1aQqVs2jKyZ8OrMsohdLpSw0rE8BHtz9yjaAf?=
 =?us-ascii?Q?5iQRseAc/0ln25BMkFI8h4cUnwDCUXF8GYfzdondrx1IOg3N6xmJ+tbwNIi/?=
 =?us-ascii?Q?/vhAGGxykLZ1KZORrw2zR6VZwfFY0r6cd/XxUXaoDG+7vGOGWmqRrSyMyeIf?=
 =?us-ascii?Q?fQ9UIKSUMBuolQBUuC5+r7j9+gHm4WNVGiYyi8g/sxHcb6jNZC7bVl1/+yGV?=
 =?us-ascii?Q?POZqArZb4FSiQhBTWSqrtDJVGQsITnh41u4aeIIkhLaNNssyalc5+4vOI97e?=
 =?us-ascii?Q?Xx835GgXl3eJ9mN/ilx759/pX/ms1sFJ3bpspJB+mDWgUDcmfvGz4t5GMXFA?=
 =?us-ascii?Q?Vr1QApFBDtmJ/mfvxYAU+RFF+0z5eQqZ+bN8QNJ+Yc8CgrsXOmGRje3WMhBs?=
 =?us-ascii?Q?D27e+GDOEBt1ce5ONsm13LXZdunDeNIP6gfvF+epeAwae6XAzAsW0hRyRsdw?=
 =?us-ascii?Q?rSGrTAuF/sURkeMmcLnZiNuVD2hYL2h0j1nenCbTojEn7Zf6v5eOLIAwKRSp?=
 =?us-ascii?Q?mmGphhdMxc8+USbh1zjTjLPoR8X9sTtq7psIl87SnWr+HA/WI2y17/0mbIb0?=
 =?us-ascii?Q?kDbJh38M0oSkn/I9E6ymVImVncOeqBZrhdZFH664BmZO50RkaGTrpK4k05/1?=
 =?us-ascii?Q?t+OIMKbeZ+vAjC3MaCOD/7CUiDZoxbJU3iTqHaraX8MPpATGg/Ijzz5Q+uB4?=
 =?us-ascii?Q?BcnWlCN/uJ410Vk3aQfgDoS6SZJfvJ1JR8MVox0XgJRd1wvp0BFisTD+lWzz?=
 =?us-ascii?Q?yNl6hwofZY5AMunv6wnkSBVLUWk2apd4zU9/a7U2bu0m2yB6OrnkuOQphhl+?=
 =?us-ascii?Q?lkasYwXwGKzvgtPwXbGwH0/TVRFp9RSUk+9eJ1wRHzPXcKioS6RfMeuuH3i8?=
 =?us-ascii?Q?zWc2DBvqSYE+5CSAkO7Ot5FOAy7YjskURFQabL8WtbRkmDEyxT5RsgVCTxzk?=
 =?us-ascii?Q?rpOLt8rJqYfZqrEJt/J03d7Jz2Mt1DSvMzd3Ukc/h2h93pIiO6hAu9KtraY1?=
 =?us-ascii?Q?S+ie9fZl9AT2J9GJbAkUL31Qccu2sx5GhO9/K+nvbV3Vh3NWL5+JH2sDk6X7?=
 =?us-ascii?Q?PiV/2oKSBoF4tDMbizbjVPUdhhCiNFcD7I5JoMff?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b3a86e-77c6-45f2-04fe-08dd3b6d7094
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 05:18:58.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGAVzqSfmvIUYYUW1HvoIvkUqggGBBMbKrq6eWOgQogVzUL3RG7ZlfJj22lqYgLmYaLzGrc3c1k+FAAIqS6kbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4302

> Subject: [PATCH rdma-next 02/13] RDMA/mana_ib: implement get_dma_mr
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement allocation of DMA-mapped memory regions.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/device.c |  1 +
>  drivers/infiniband/hw/mana/mr.c     | 36 +++++++++++++++++++++++++++++
>  include/net/mana/gdma.h             |  5 ++++
>  3 files changed, 42 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index 7ac0191..215dbce 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -32,6 +32,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.destroy_rwq_ind_table =3D mana_ib_destroy_rwq_ind_table,
>  	.destroy_wq =3D mana_ib_destroy_wq,
>  	.disassociate_ucontext =3D mana_ib_disassociate_ucontext,
> +	.get_dma_mr =3D mana_ib_get_dma_mr,
>  	.get_link_layer =3D mana_ib_get_link_layer,
>  	.get_port_immutable =3D mana_ib_get_port_immutable,
>  	.mmap =3D mana_ib_mmap,
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana=
/mr.c
> index 887b09d..3a047f8 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -8,6 +8,8 @@
>  #define VALID_MR_FLAGS                                                  =
       \
>  	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
> IB_ACCESS_REMOTE_READ)
>=20
> +#define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
> +
>  static enum gdma_mr_access_flags
>  mana_ib_verbs_to_gdma_access_flags(int access_flags)  { @@ -39,6 +41,8 @=
@
> static int mana_ib_gd_create_mr(struct mana_ib_dev *dev, struct mana_ib_m=
r
> *mr,
>  	req.mr_type =3D mr_params->mr_type;
>=20
>  	switch (mr_params->mr_type) {
> +	case GDMA_MR_TYPE_GPA:
> +		break;
>  	case GDMA_MR_TYPE_GVA:
>  		req.gva.dma_region_handle =3D mr_params-
> >gva.dma_region_handle;
>  		req.gva.virtual_address =3D mr_params->gva.virtual_address; @@
> -169,6 +173,38 @@ err_free:
>  	return ERR_PTR(err);
>  }
>=20
> +struct ib_mr *mana_ib_get_dma_mr(struct ib_pd *ibpd, int access_flags)
> +{
> +	struct mana_ib_pd *pd =3D container_of(ibpd, struct mana_ib_pd, ibpd);
> +	struct gdma_create_mr_params mr_params =3D {};
> +	struct ib_device *ibdev =3D ibpd->device;
> +	struct mana_ib_dev *dev;
> +	struct mana_ib_mr *mr;
> +	int err;
> +
> +	dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +
> +	if (access_flags & ~VALID_DMA_MR_FLAGS)
> +		return ERR_PTR(-EINVAL);
> +
> +	mr =3D kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mr_params.pd_handle =3D pd->pd_handle;
> +	mr_params.mr_type =3D GDMA_MR_TYPE_GPA;
> +
> +	err =3D mana_ib_gd_create_mr(dev, mr, &mr_params);
> +	if (err)
> +		goto err_free;
> +
> +	return &mr->ibmr;
> +
> +err_free:
> +	kfree(mr);
> +	return ERR_PTR(err);
> +}
> +
>  int mana_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)  {
>  	struct mana_ib_mr *mr =3D container_of(ibmr, struct mana_ib_mr, ibmr);
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> 03e1b25..a94b04e 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -801,6 +801,11 @@ struct gdma_destory_pd_resp {
>  };/* HW DATA */
>=20
>  enum gdma_mr_type {
> +	/*
> +	 * Guest Physical Address - MRs of this type allow access
> +	 * to any DMA-mapped memory using bus-logical address
> +	 */
> +	GDMA_MR_TYPE_GPA =3D 1,
>  	/* Guest Virtual Address - MRs of this type allow access
>  	 * to memory mapped by PTEs associated with this MR using a virtual
>  	 * address that is set up in the MST
> --
> 2.43.0


