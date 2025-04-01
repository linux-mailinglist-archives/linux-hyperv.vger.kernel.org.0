Return-Path: <linux-hyperv+bounces-4765-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47716A782A8
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Apr 2025 21:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14BA67A5005
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Apr 2025 19:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D71DB92C;
	Tue,  1 Apr 2025 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="grdGuKv4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020137.outbound.protection.outlook.com [52.101.56.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832151AA1FF;
	Tue,  1 Apr 2025 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743535089; cv=fail; b=RwufoWKL4xMg9gxtrI3sfyDFcml66YH21MSqstpBohxiCjWMW8pqKpZTB9obP1Qhx/vRtud78PC4aFBDGSuzzUJMKreprl6dWUbqlrTuC+QBccU7DMNZLLjEk3m9BUspD2u4w2k8D5R9NPYPgkjsc2HL7Q1LNXXZwz7vOst3wrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743535089; c=relaxed/simple;
	bh=emOe2VN7f0P8JMdvNlH7JiX8VbG8srxyhLepes2YSIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jlodb6V/09915znmh0JuAhlf0bfuozLQLCyslwkfW9yuGq2ZJ3b7W/ZQTQ3PZ1vsG96LL305TX2PQWD00SLsqdjXGTvuk4N9DUKpVlsaFiLvOEuXqrALMXOPZpMOR+BuEc9MXlycX10WBsbfyNZWlnYdNMqxord7nccVg0Otc9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=grdGuKv4; arc=fail smtp.client-ip=52.101.56.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIiDPRTrbMX6G0AzpBER7anm0+K3c9O5W++Xr/WBFINCDRcd8n43Jv38x/v0YmOCHoPIaHy1Uq8g+/1rPHlkmTKKEI/pFSPxVqt1PMH76ynoFXKgSChQODyVPQvmhqT0Va899x3qtlWjQYeg2EvioI+EvT19BqP1eo1IIsH0rcXUl2pdNvAtdDtloMX2Pq8A+MwgHEYFW2kW3uSSK11RBaT0z3c58ygXokEQqx69RdqRYb3BOMg2nOJxDLtjdm9fpoqAg58WNYcxVruwdz9pM7NbDdK5IKDcAfbqPG3uEkmG+hlBdKCDB/it9xvfbzSZJANgBmCSjfa2bU2cKCfLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxYDHg9NwGMtAy9ZE/JedzgURJKFYz9Mu4RV+EIuOpE=;
 b=Uwou/tWi4bqLYRZuJZr4UmI4M8fG7n0xIsF4PHOz0FWn+uB6R7X30/OOfvznxmIyUG+R2XCALC/ZNx8zLGoKkENYVyrxJ61EPmKYex9KFKPKXWnGYEN9cB4ZVKRB9xNwaLQzLYJw8rUtonKskwsjba01pocPzXoHSDtFijt0Aa4DcST58klqz2066S8XR5agl1jJJ5GB8Um7YMUi7iqZLgAzP+6G3MycF5MDTOcsUIdfKPWW8qM2bJm/cL4U9VJbQbwI7tuGsAYepMhBa2CK8roZbjIVN5vDOSlGSsCLjultCNJRoCCuubPOTcHOLPT0Mn0E8qFYs6GRiwJWQ7oaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxYDHg9NwGMtAy9ZE/JedzgURJKFYz9Mu4RV+EIuOpE=;
 b=grdGuKv4TLDrUHK4+KuGPq9VInxnQIMZPlkX2StjdwdvuD+bBsXx2ti7/gV0S09jl3RIu72Rv3EcRQ0sGtfaEyTHbVgrLQRsPt5RSjOcFrWj3Aba5RjNJSAiac0p6+7+9lD07+aWtda/aQhbETcSJ6XsgdeJdySCwibSugWOlAo=
Received: from BL4PR21MB4627.namprd21.prod.outlook.com (2603:10b6:208:585::7)
 by IA0PR21MB4004.namprd21.prod.outlook.com (2603:10b6:208:483::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.6; Tue, 1 Apr
 2025 19:18:04 +0000
Received: from BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb]) by BL4PR21MB4627.namprd21.prod.outlook.com
 ([fe80::7cb1:a2d1:137b:34fb%7]) with mapi id 15.20.8632.004; Tue, 1 Apr 2025
 19:18:04 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: RE: [PATCH v2] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Thread-Topic: [PATCH v2] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Thread-Index: AQHbogQ4C/lFQDjS3kCzOLhPcF8IYbON2/SAgABWz4CAAPdt0A==
Date: Tue, 1 Apr 2025 19:18:04 +0000
Message-ID:
 <BL4PR21MB4627E73164911623CFB98BADBFAC2@BL4PR21MB4627.namprd21.prod.outlook.com>
References:
 <1743401688-1573-1-git-send-email-shradhagupta@linux.microsoft.com>
 <BL4PR21MB462765E191592754911DB67BBFAD2@BL4PR21MB4627.namprd21.prod.outlook.com>
 <20250401040609.GA11465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20250401040609.GA11465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dd761157-ee67-419f-9187-ff4472810408;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-01T18:51:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR21MB4627:EE_|IA0PR21MB4004:EE_
x-ms-office365-filtering-correlation-id: ca6fd1c5-e775-4dc0-6d9a-08dd7151ed47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HhaSGd88fbMsQdinCn4AaezxHdZPOSmD83GWGCaIGR5stbyYDMSMOe7fzGiJ?=
 =?us-ascii?Q?4Xbl4wG+qV7PXHrONAOzkL7v4b8pyBtOH4FkGTT4Y7SPUsfZ8JcOaXsp6lIP?=
 =?us-ascii?Q?Kqj1tWS0+FZuDlvegmjirHbw2gW7Mtm/fKvKB3W06zjRL3vOuo7PzUwapSRj?=
 =?us-ascii?Q?j7kGIoTfg8zBiGNUumQOL8f90J8KIA/6LB6TMAg5uzrVeo8iqtguhPJ9st//?=
 =?us-ascii?Q?eirDrfOqNt6NwCkIM00TavIrdrH8UnMCALqFPwit+YcldO8h++yCoAY44Zlh?=
 =?us-ascii?Q?WZ/N1EFJlfSqAd6Q1Fk9c1qlhj8DaD/agkTQC/k8N91o3WNvcfYZpHIqutjm?=
 =?us-ascii?Q?G/FBNmRVcUe7i/fn7ZmbiLc5Ncjbk4BkZg7sAXDP+z893+LHrfZCcefNHhtU?=
 =?us-ascii?Q?l2xc1n5xHDPKPYgbhkxLl3baHm0Sz6ZoZyxDDAInkU2TJ23r/lfDDH2qkPxq?=
 =?us-ascii?Q?7wrcfOcsR9JkDYCmhhtFB4KXPEjeHZMj3MgyB0zpmISvohw40vWBZ706q5v/?=
 =?us-ascii?Q?GZb7xYWD1hCyY5QO0yi+4qHSy47v3FGrrxQGlpBzydsuml6TUt4N2OQgl42Y?=
 =?us-ascii?Q?pjM/hVohRoU83CdJ8PmPSQVOZ+FhHYPrCK4SK6iY3hB8gAJtGnYOax/OwH+C?=
 =?us-ascii?Q?GCXPcHxeRTOdY0RfdgrmNPXhNAL2YO1mfUmU4h4H7ZW/oJMGN6/Y2B83t6Zu?=
 =?us-ascii?Q?8youDlKuN7GFcDXaeYRxBK0LCJPnH8007hsw2I06l0rzK0cXus8lj4zKNkUk?=
 =?us-ascii?Q?j1HA1KxtENgLPJMCvnDCrWQN93idd009LhhrW+IYV5w2rUQyxWvB5L64yIUw?=
 =?us-ascii?Q?6bqJ5UeG9qef/PfZdrIn+gjEcCh1WahN1CAkRZmkSStXb+gg2RfTF2yzb56K?=
 =?us-ascii?Q?5UBgkLnzZ2QFCf6omgnwm6/ZoK2SePfrr1myS8VCvrmlPDSx3j9efwPgQrrF?=
 =?us-ascii?Q?siRvRVsJbH9yfBnfU+Hm5hj9/qtrPrUmBX9dH5LVD5im2PYMfrtcyLVOJmCb?=
 =?us-ascii?Q?9cA2uyZYIeAk8UcI/RY2h9rK6NUyd+3V9eh5fAKvkG9To1rJeNAPOWZXuENo?=
 =?us-ascii?Q?HrKDm9zyAUekMNQzgPMBE9srxWTMth2NFZ0QEqoWpwrshWthzgT5Z1T93ACr?=
 =?us-ascii?Q?Ol0Lt0QXVwPy/msb5QCreGJvoml3O1wqSqT2/biQn+61kLXozGlHiGNXDrem?=
 =?us-ascii?Q?w6XHZ2CILa7S1uq0URqjx3VDbNr1G5Y4gebMhyYQ70nb2Scvv8B3nKKnpRhf?=
 =?us-ascii?Q?FdT7xPjvW0n6bayqKbUbw33lEnWkNdC+ZpMojm6q9fxt/5OHDC++ZXQiVfGR?=
 =?us-ascii?Q?fdb2xHgRStwujIhQd5wY/wzyEahiDlyKUHLB05NhIBD89cIVbESgQZ7mra90?=
 =?us-ascii?Q?mmE0YzSlAoePxxsCoh4RWqfS5GmDYz1bs06LgXBuyF3BPDPZHBPMyIDEmvPj?=
 =?us-ascii?Q?4ZGyvRIUDgnOjuLuodAsn+FPd79QnFz7kxaqRwFxnZ9r9BDD7a1+DqG38r46?=
 =?us-ascii?Q?cPgoZpktvf0bpSE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR21MB4627.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+17W2K+++Y/WLm5kghirauhG7DaEi/lZOCadfpn5XJROE8tCnHlHwM9lJ2e6?=
 =?us-ascii?Q?ER1ox7iPTDsXJXcaK2zHWFJZQFfTiLSqhBI4AzmmTiZiVAA+ae128EhMu/9n?=
 =?us-ascii?Q?tvQNJmdysanVORedmvhqS27vzIZDuUmjgGBm1pLx28Q4aPgse3y2y0+2vjqy?=
 =?us-ascii?Q?Oqw2nWw0luFIlArx2VorgPm5+W5BQMhQnsc+U+BB6JmyuVGnMlZd/JxK3yGg?=
 =?us-ascii?Q?rahCA+n3xRcEVt+n7wLK416hX1CKuzQ96/GXMeWdK/4pkR/6fWOT8S/Rh+IH?=
 =?us-ascii?Q?fyR7YTtpvvCSiBImMXgPGuUl8mbN28lt/tzV7lJL65kgYO9Zvod6nbZEX/XN?=
 =?us-ascii?Q?rv+ZqN2TwniFFNYQ8u8/+I+69xT2/tB0uI81TlTlnKn+PBjhM4ecylrzye4q?=
 =?us-ascii?Q?4gWzK1O0n/lmjWDJhbTNZfDDsQ3xU94e8Ycnxrl+l23mbjoWBg8bjkoCT9lR?=
 =?us-ascii?Q?5MnSj70RBfgxiXAPLiRaMBXPO8YbAxRUx9KKH/TFVW8ev5AbECu5L7nn8O8D?=
 =?us-ascii?Q?p1nxV9opygKs0c8p+Es2k1dA1JFlo6QuzxHuKJ6rdCHOEJpVIr7v4lZ7DiWW?=
 =?us-ascii?Q?Do/Zhx0gQ2pRW2tpcCI9UvXQgLgmUI/qamtiXYf7TTJ4wYWF05Iz0x0LRktG?=
 =?us-ascii?Q?vwbAMx5AXlzqqC9T7QcrbKQ2Gv7CTAblFJK6f1AgjBR0dex5Zv5oZgnAbKMQ?=
 =?us-ascii?Q?Tec1VztWFVyWNd5/fQy3LU4uU2lvtJYViTcpmPavlZUT2KIpUDav+0q/SeIE?=
 =?us-ascii?Q?yepc4dkJI/7J4YegHe2x9m2T5ZhZA127OFs+ZImUOTbDBspVutv2Hko/RRBB?=
 =?us-ascii?Q?llstPIn/t2BiIr9BOrnObiKKJichBaHxpdKgQSa3bXGTa6yuDyrn/o2NtM7Z?=
 =?us-ascii?Q?RNGbTeYKaJwodxpw/d4pBwUVleTSHhzqBY02aoQV9b7+FZzZ5It7l94/dXCC?=
 =?us-ascii?Q?EJD2df/J/DYqKE1VFTRhAqux0SbzPl1hq3ReKuppxA+cIkBqZm1naiS3IyIf?=
 =?us-ascii?Q?n9Fi7RgD/AnZbO4djV2qKfqig2iqpgIltOzogYD9OgFsXWaf7Ei6NTSAsKrJ?=
 =?us-ascii?Q?GmEZ79kdLHHEj23O/WMXha5CCbKskn9PPbhHhD0P52Skt4VOt8AxXWBdlOfL?=
 =?us-ascii?Q?iuiS/m60RLPEmPpxlsrkqZAHY/+ViH7GX7hG7NaubKFXVObgKYLQl78mezPU?=
 =?us-ascii?Q?fEkBlzAOCthXQUjjh09RYyRrmj+rlbeHNr2u/6dcPx11HxU7nvS5wBSUeTPP?=
 =?us-ascii?Q?7DaiPr/6lgPlRSCVrGKeEEiMC4+roRJB7FYyiH2EIr5KNAeUhtKQz0SJA2ND?=
 =?us-ascii?Q?9BwW0dPRO11gC6Sjk76ZFQYllxLLwGUDPNDiRWp63XW0yelxwK9jxF7DiziT?=
 =?us-ascii?Q?MRg2fxZVyOk6r+c+3m1ZU2anxjnIxLRPLeSyskghwxuZQ+GxUsi4Lr64S+th?=
 =?us-ascii?Q?9jaDa42dNbf7mxpPHbstz1tsFXmG/QOHHnDEz0ujmNMAGEUJ5GFrRmQHf5pV?=
 =?us-ascii?Q?fUzDZv7cdDX3a5/9GNuuB8AVZdaYdyoAfrrk9NcvNNdZ2LSrLEztmIwCfamt?=
 =?us-ascii?Q?vvbHGiKF6zYMDInK4JmPKrr0GP+utdT6jCKGyCnq?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL4PR21MB4627.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6fd1c5-e775-4dc0-6d9a-08dd7151ed47
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 19:18:04.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zHFKlfIQldqWjC4eH9S1dLWRIwjRm0SzJ7nse4j/4MhH24VFm+PpLvuElW8ggS32PoY7DMwGzxp96j2w/Hu68w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR21MB4004

> From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Sent: Monday, March 31, 2025 9:06 PM
> > > +static void convert_tm_to_string(char *tm_str, size_t tm_str_size)
> > > +{
> > > +	struct tm tm;
> > > +	time_t t;
> > > +
> > > +	time(&t);
> > > +	gmtime_r(&t, &tm);
> > > +	strftime(tm_str, tm_str_size, "%Y-%m-%dT%H:%M:%S", &tm);
> > > +}
> >
> > Now the function is unnecessary since v2 uses syslog(), which already
> > prefixes every message with a timestamp.
>=20
> Hi Dexuan,
> I have deliberately kept this timestamp in the raw message so that
> if/whenever they are redirected to other file, irrespective of the
> configuration of the syslog we have valid timestamp for debugging

A message produced by syslog() is always prefixed with a timestamp,
and IMO can't be redirected.  By "redirected to other file",  I guess
you mean systemd's options StandardOutput=3D and StandardError=3D
for a service, but those are stdout/err, not syslog().

> > > +static void kvp_dump_initial_pools(int pool)
> > > + [...]
> > > +	for (i =3D 0; i < kvp_file_info[pool].num_records; i++)
> > > +		syslog(LOG_DEBUG, "[%s]: pool: %d, %d/%d key=3D%s
> > > val=3D%s\n",
> > > +		       tm_str, pool, i, kvp_file_info[pool].num_records,
> >
> > Can you change the 'i' to 'i+1'? This makes the messages a little more
> > natural to users who are not programmers :-)
> sure, but I am just worried that might cause confusion when someone
> tried to co-relate it with the actual kv_pool_{i} contents that start
> with 0.
IMO these messages are mostly for admins, who would feel more
natural when seeing N/N as the last element, compared  with N-1/N.

Thanks,
Dexuan

