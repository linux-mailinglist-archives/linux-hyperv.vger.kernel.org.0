Return-Path: <linux-hyperv+bounces-11080-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJimKvEKDmoa5wUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11080-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:26:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0459848D
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56DCF30346D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 19:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2E0346FCA;
	Wed, 20 May 2026 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="phTlK9k0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012011.outbound.protection.outlook.com [52.103.23.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641B345CDD;
	Wed, 20 May 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305191; cv=fail; b=AP4qZIr9QK92KqI9JtE49yNlXIWRL45na1/J9elnlaA+DAmiEM62pL1K51wXz8RIOFSawUwFcfeQxpMM2uCesg+fEjgYD1hnbmoN4GHAmnQzInipRNhBMSieGDAEGBE3BzBFTpYrQSwCveYuXHg6LYssmoP03ssQ87/dxWJHnic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305191; c=relaxed/simple;
	bh=KIqcy4sVxd9105IWS9vwF06Vsm/jV5x9fVCkl6tLDDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYpDL192JxxevTVn7Gs3gh8wyDi48Bh/7NxBFElhP03eIpZrYXim8WXd9bYaFp8EV9Wpo4r4FXydHeFhKLplTdyeF1NGeIDPZBmcrBy1XscoW9hfPjfH7f4abaZAJlNkJkfUFJDkRBPf3FHzA+6QI4U4rmOnYpnQy6R5m87RgMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=phTlK9k0; arc=fail smtp.client-ip=52.103.23.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKQxfOjfcDRRUX9E5heDM/oTIBYAUmS3hObLW8aBr/2d/fWCUauGGYWfHKj9z8kv2OZFCGQDNj1S9W59SP4iFTTYRDIE+d8Yff0ZFdROBD+F50HiBTAJGo24vx8Pjy3PcaWt8q/eLpb80N9a10CnL+ItLsLj5UqQnc/M3oQ03eIpCFRk41LiBNKgBVFsJcM+/NzJMlOCek+B3MfYH89k/rv8N5lKOSjrsQg5dy0f1naNCmHOqDcJVLQxgDgB4bgtRBSyKZHAWCgFkFMgxpnEkm3EuxPEG8RTWTplGNsOPv3fv3m7VONMe6sQpDEJViSS2R2eFV7RFuwEA2hLZ6lKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOiwu84HtgoLGUkM2IBOL2PugBvIjHjOXW7oNNPqvOA=;
 b=knlhECnao/wiN1X1mVG/W+hdbWXIWmOr2cI7Kpya0oFmWqNFgOmAGjoEUqUA+Ausmr2UPA6SEkTYomC3CVNs8odIZnTmst6jkhSnFanUbkh5HzhhuAQxJB2R/OVj8nvNIhA8GA2+oM2D/4eSM1Qil2XiMoYbImhtbhUXi/wMyannlGk+QyGPOt9w3+eEX7xOJpvPSlkMun7kc5gXTaG5jzb/98OmWTbkgduEYzzUf/EFwyESdWlcCm9Q+1yeK9saTpCiTfNH93KYNu1/fNSBXr4pT9ikcIh3mMSVUYcn7EhIWu8HC7LmRlV4aax8r7tusUTpYdzUOzhTLXoE9K0nKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOiwu84HtgoLGUkM2IBOL2PugBvIjHjOXW7oNNPqvOA=;
 b=phTlK9k0cnOfif5vvb9voQOe+vTcuNBJ6o1nJhHaFtcUf28s1LGACMxiya4GAX2tnyKZzCOB918qUwS5HlL/GjqCJPr00/5vuO/5oT4TE0j/88rwn4qyvzyqpu5xRD5gae80+rjco6WTnUXd9vi8LGQXMBamW0jlkjLTsVJ1RXmwGScOU0JAeFMSZTm02UqKiUR2xZLkTstLvomqINKsooLGStNhNEgyeeXva1hT4PKI5xBqolsD3eG8wkbiuke4GADAnYcEIjRmCbFETSe2Mux9uPy9Z5Gws6TnA5TMbXzIIDY3AV6spUGCNYpqGEHob0MCcTHeMoZcu6s30yfJIw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7044.namprd02.prod.outlook.com (2603:10b6:a03:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 19:26:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 19:26:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>
Subject: RE: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index: AQJDuACGb2SFxAgG/WSEtOdKOL4HjAGk+UcvAojevN21KBm8AIAAHqSw
Date: Wed, 20 May 2026 19:26:24 +0000
Message-ID:
 <SN6PR02MB4157C1EC7F5F69C5ABDA9C7FD4012@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <20260515223545.GL7702@ziepe.ca>
 <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
In-Reply-To: <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7044:EE_
x-ms-office365-filtering-correlation-id: 087a797f-dc29-4c23-7810-08deb6a5ae66
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQmM7KNZxyCfd+5xcyAOZnIEFheE2WWi5GCBDVqqcid4o24Rif+MxHwzDkXSESeIEwuu25EsBrTZ8o4gkz8VBm+tNc+1y6PmOCbjMdgYtZ5DA32HU3kkLaHmL6RFeT83kNo+k3j6bG2ZDujpjLCfqMlVrckESbGDy3IvGSGYwej1lt/50qhCSxotBAnc8usKf2YLGuIFfrm0p3UEs6WybRUTdcKs88AswdYVnEYMeS2TGEWRlnPaxg8OL5dOxI6/Lx58j99W5ZRE+Qesvl+wyZpZpYL8NZday0RDzImWN+dpI7ybkUs09ZJJn5eUxKcXrAOKajJl9DWr06xoz1M+tzfYbiKLvq8nWmw+Yoz6umEB3Vx8PxJzRepuRkr8wKw/LzPb3O2eFJD2hXUjePeg7TSRRL/O7NgWttFw1nr3q2k1OT5vI5IrkkuY4SX2ZsqqXvj5J1OGRiJOcrbmhr+uXYw/2bg+6tZ8Yqr8Jm5OBlhn5r31zfJ7kjyBYgGRzQEumlzLiER8228aXA/Qry98GmBRNk81hPBGE6vuexwMG1wIdDoALR6PAUgmfHAZivDhwUOL4Z+HTxlAz59RnrLHv4K+rgM1cdSyQKN2SA4QHTQaB02wCrfj7Vqofn3O4cy6L41xc9t8fjv5QObuMU9iP2EVzTmqmUx1Pa8dolOfsFGbfqO7LgxePhil/4wE6Jtyh97ZA983prbUlimtEtvC4rtEH2Rj6eqVfFQ=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|51005399006|41001999006|31061999003|8062599012|8060799015|19110799012|37011999003|13091999003|19101099003|3412199025|102099032|12091999003|440099028|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4dl8EwW/fOX8GM/WfDVFpRQWOADyh3rGmKSNdbi0vmWEMhC2ogIcIbG7Qz63?=
 =?us-ascii?Q?LbsdWzGFA+MCMEOh5fYMtb7Sq1C9Z/Z4URk6eFf0t4cpCHHj2OB+N02kKqJp?=
 =?us-ascii?Q?hZt6KFawMtvhErDtUWfyq7Il9pqerOBOO/GFraL847dvXdIfbgfEQiHgyUQf?=
 =?us-ascii?Q?2/CCIiN6xGf5Tq0Ryno6cLrhU7vJDGXkXAXUAQH6aZbM3QimSS1Rfx1pyxwe?=
 =?us-ascii?Q?tC0ys0uWbqGVRabh8LA1JDQ+hfR5ZsS7dFQNrMNt1wACzSXP1c7j8UJiFznK?=
 =?us-ascii?Q?ZoWog2uy2VnAAmj87TEQAEyQtPTY+y5nPSWlo5H6wTRDRCOKxRw1d4Pz7Ei1?=
 =?us-ascii?Q?c6KfPYD6Yb+OWL7ojPPYIj7wWgXJqoFE/h6HsItssth7OEWzNyOAjgyfQdF0?=
 =?us-ascii?Q?RnoDS4+5A8QcK/DPd6J2fs4aaHYPVhbxuPX/wASj5BLNu60YhmaBp9ltgs53?=
 =?us-ascii?Q?2rUL3ypa4SiOQBilp6+3roeftU4IFxvExeV7ABVyEaGnwcVW3k0YwWDmwrIM?=
 =?us-ascii?Q?fn+2gdSuWbaH8dhSe/n5+TtSIEbqcNoEdvomlEQzqXk6GNSk6ylqiS6jHA2o?=
 =?us-ascii?Q?QRbwhj7m//3MzKj6DZn8SxWDX/xXGoS6Xzh8R6IMdxqD7TCFSkqrlDsqoQ/p?=
 =?us-ascii?Q?2Fiq5r9rXdFhieGluD6WrAGhspJp2SJKe+lN4hKwGN2VlThhps/HDpWJ9vMT?=
 =?us-ascii?Q?5Emd9MazAdQ/Rf0L8D3kErlD0VorSjsJbvJXzql53xdSy/Bb9GSiA7P9fN7l?=
 =?us-ascii?Q?akH4DtaRLf7cNeb5F1NOV3AOrH4/C7ZQTZqjZS5JOE19BRMEOrQhs09rvXeW?=
 =?us-ascii?Q?0EqSZZeNwhDwTXOW4QMPAC6270lz3GpNqiNK1FxJw2R5qIaFrYhZYXiLAhhO?=
 =?us-ascii?Q?E9sUBmYJETHjDkxsWOpSgEHu35HgAh7RFcmjS7G6gTF/cvXDz09wmIvpAllJ?=
 =?us-ascii?Q?7mh9Ps24oDOTjg7G20KWMpC/7IiKl8IC2NMjZQ48Q7XBZ4eyejnOWNacsHFN?=
 =?us-ascii?Q?2GcmTHDlO2QMC9VGg3fUSjtiCRPlwo/y9iwFczwVjo1xxWtwF9NZSnXsU+nA?=
 =?us-ascii?Q?2LL87p8R?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oEV893SdpVdjtvPutoEEjtynpm9cwo5SCwsVl+juewh4Bx76VmPSwwIK7taC?=
 =?us-ascii?Q?EQp6X0iQM3eOyrlWjMWkUdq4oqT6dh2IpjGb68VXYgJ9eerrv1AIxh2ADSNn?=
 =?us-ascii?Q?wRuIw/7kyptibGw+/XAfHGO+hmd6uQdMh5gYiX/q7+P6MeGuxkx5ZXrnRqRc?=
 =?us-ascii?Q?djT+9cnM/xBrjBsNJtCSphM/Yty0/i2oDd4XZjsu7YbM8u2vCIAfLlflFX15?=
 =?us-ascii?Q?r0rBcmevtWnN/DjfgARvaxy+g9c7zmocxW1Uj1TdCGt5c5QMM3Ex1utRUkFZ?=
 =?us-ascii?Q?TILctu2hDUJdW54L8IKlhPoM0TbxWj7WUNTShrnX9muiKKR3uWYv7t/eOs27?=
 =?us-ascii?Q?XSfL4yu/wWxPMuiBEXXaD9F4wovARI1P+sP4PfqbOgutD8iCZVb2iqxoDu4V?=
 =?us-ascii?Q?qKP0j1KhCwmbpmXSxBOnkez5NTyKaG2Kg1sFzCmSO44PJfCguMX5HMesM4kY?=
 =?us-ascii?Q?3OZ57rJwatXzWziAqBeI7QkSFHRiRciLK3yWGUGEeqBQkdeAEYAZM6yw42vc?=
 =?us-ascii?Q?QZyeKc81Vvh8u9v8e863xiTKoaexRfKeDjGAt2IDupRssWtiSe8Zu5D3oR+0?=
 =?us-ascii?Q?Ac5RtYuJMgbbxLFJx4X5uvMowLr3+C2hpYwNfn/tPbXo5AXzKaLhYeyheT4H?=
 =?us-ascii?Q?Mvce7i0bK+stJ14fcIgRS5rgAnlGuUlWpZXe8KGRyLd2BByRx2qam+gtMr0b?=
 =?us-ascii?Q?/BsFXj7tbQaR4DPSItliZ43/ZytbbYkuTs6KGVS2fhOZB0WSz1WsNpdyKJxN?=
 =?us-ascii?Q?NFhHVLmZ5a3B+pulXJkgMrNOOOPW7w9KleDbZxOtsy2fgUuuoSW4nAKCpOCi?=
 =?us-ascii?Q?cqg9c1Lqn595n5ucVVjiTfgWP93BujZ8El0F0Y6qBckCdqT6udFAcXYKLV+h?=
 =?us-ascii?Q?oVMdq9ggGZM4+x+zdUL2L+CAa7X5w2ULO/m0GL4UDUPcmAL3m2r883PaFkcs?=
 =?us-ascii?Q?B2OpGrM+z36+HlzbnVidKd8wBfLv0lQzDHU0hPQBVtk3pF3d0clFnGKp2SRw?=
 =?us-ascii?Q?Snfy6L8bDFteIOI4e7f1uRGLyDZy771uGWj+HwCWf2Vp5y3VQ3Q27Y6KE9Jo?=
 =?us-ascii?Q?J8g4Waqj9/l2dg+xqFm2RHB0WtkWYnA1jEXRZbaeRp8VRmaEicvuB4WXshq2?=
 =?us-ascii?Q?/dlaXUJkrAtts7MxYR9D/VVR4H64NrzAdsa4uJ6wv3q33a0udsvaifNQYBnX?=
 =?us-ascii?Q?t2T+kvDhUbkyrChgZKbKRwYhdzAxGpdZRAafeA6tgEgjadc1JMGOSfSoo65P?=
 =?us-ascii?Q?Dp8KVkn3ZQIVuNBvZvf6XwCUdQcKlLaNb7BtKWoGr3qCEkOae4rvc+MjlP83?=
 =?us-ascii?Q?4bY1v+n4pFWAMo+x8COTheeantd6sa0teroWgF/HttkiDwhbt4NMd0pOfUDX?=
 =?us-ascii?Q?scjHh84=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 087a797f-dc29-4c23-7810-08deb6a5ae66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 19:26:24.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7044
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11080-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 54D0459848D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Wednesday, May 20, 2026=
 10:15 AM
>=20
> On Fri, May 15, 2026 at 07:35:45PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 12, 2026 at 12:24:08AM +0800, Yu Zhang wrote:
> > > +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *i=
ova_list,
> > > +					  unsigned long start,
> > > +					  unsigned long end)
> > > +{
> > > +	unsigned long start_pfn =3D start >> PAGE_SHIFT;
> > > +	unsigned long end_pfn =3D PAGE_ALIGN(end) >> PAGE_SHIFT;
> > > +	unsigned long nr_pages =3D end_pfn - start_pfn;
> > > +	u16 count =3D 0;
> > > +
> > > +	while (nr_pages > 0) {
> > > +		unsigned long flush_pages;
> > > +		int order;
> > > +		unsigned long pfn_align;
> > > +		unsigned long size_align;
> > > +
> > > +		if (count >=3D HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> > > +			count =3D HV_IOMMU_FLUSH_VA_OVERFLOW;
> > > +			break;
> > > +		}
> > > +
> > > +		if (start_pfn)
> > > +			pfn_align =3D __ffs(start_pfn);
> > > +		else
> > > +			pfn_align =3D BITS_PER_LONG - 1;
> > > +
> > > +		size_align =3D __fls(nr_pages);
> > > +		order =3D min(pfn_align, size_align);
> > > +		iova_list[count].page_mask_shift =3D order;
> > > +		iova_list[count].page_number =3D start_pfn;
> > > +
> > > +		flush_pages =3D 1UL << order;
> > > +		start_pfn +=3D flush_pages;
> > > +		nr_pages -=3D flush_pages;
> > > +		count++;
> > > +	}
> >
> > This seems like a really silly hypervisor interface. Why doesn't it
> > just accept a normal range? Splitting it into power of two aligned
> > ranges is very inefficient.
>=20
> Fair point. I'm not sure how much flexibility we have to change
> this hypercall interface at the moment - it predates the pvIOMMU
> work and may have other consumers beyond Linux guest. On the other
> hand, having the guest specify 2^N-aligned blocks does save the
> hypervisor from having to decompose ranges itself before issuing
> hardware invalidation commands - the guest-provided entries can be
> fed to the HW more or less directly.
>=20
> That said, the way I'm currently using this interface may be
> more precise than necessary. Maybe we have 2 options:
>=20
> 1) Current approach: decompose the range into multiple exact
>    2^N-aligned blocks with no over-flush, but at the cost of
>    more complex calculations and more entries.
>=20
> 2) Follow what Intel/AMD drivers do: find a single minimal
>    2^N-aligned block that covers the entire range, but may
>    over-flush.
>=20
> Any preference?
>=20
> @Michael, since you've also been reviewing this patch, I'd
> appreciate your thoughts on the above as well. :)
>=20

I'm just guessing, but perhaps flushing an aligned power-of-2
range can be processed by the hypervisor at a relatively fixed
cost, regardless of the size. Having the guest do the decomposing
of an arbitrary range allows the hypervisor to make use of the
existing "rep" hypercall mechanism if the hypercall is taking
"too long". The hypervisor can pause its processing, return to
the guest temporarily, and then continue the hypercall. If the
arbitrary range were passed into the hypercall for the hypervisor
to do the decomposing, that pause-and-restart mechanism
wouldn't be available.

Of course, Linux doesn't really take advantage of the pause to
reduce guest interrupt latency because the Hyper-V code in
Linux typically disable interrupts around a hypercall due to the
way the hypercall input page is allocated. But other guest
operating systems might benefit from such a pause. And we could
probably fix the Hyper-V code in Linux to allow interrupts during a
hypercall pause/restart if long-running hypercalls turn out to be
a problem.

Regarding proposal (1) vs. (2), perhaps you could confirm with
the Hyper-V team that flushing an aligned power-of-2 range
has relatively fixed cost, regardless of the size. And what do the
flush requests coming from the generic IOMMU subsystem look
like? Do they match dma_unmap() ranges, which are probably
dominated by relatively small ranges of a few pages at most,
with a few outliers for disk I/O requests of 1 MiB or some such?
If the dominant flush request is for a few pages at most, then
doing (2) seems reasonable.

Michael

