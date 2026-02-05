Return-Path: <linux-hyperv+bounces-8724-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZbBhErAthGkA0gMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8724-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 06:42:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8A4EEC68
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 06:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDDA83008206
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 05:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF8322B74;
	Thu,  5 Feb 2026 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jNnYdnbv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012045.outbound.protection.outlook.com [52.103.23.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7F13B284;
	Thu,  5 Feb 2026 05:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770270125; cv=fail; b=TTwTiXDN0+wF+GVMjonHp5sVV1zy60RNl4JAoOseU2B+4emRSSRRj7ZKpXOcN5S042xMBsdG0AW5YAtr8RfxMMFzCwupuNF133ZGtf2vq9f75N8u1UpFqMQLj+Rd9X8gMZ0hihrvXgHQzMdBVLI+FgqI0x/Y/WJianUi6k6We68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770270125; c=relaxed/simple;
	bh=i+Vd/ZNRwcb5oSlC1RxIIzZ3thRHirUgD1AbREiIOrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uE6toW+FZMztBUNvIXJCWvoYz54NZjn++sH/5z5GFsJjbD+LyVPtj9xD8TKoM+5qSrf3TK1/U6aW7vaX5uRbYs6X/qSXimE8nXDPzWoVnhAqUriEV/fSNo4BON+iBoauGxNWdnayLNDy6GaKGz578nGctPPln0hQSwVrVGH5DPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jNnYdnbv; arc=fail smtp.client-ip=52.103.23.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rck52cGdSR4qSWFiZcSAhDYiTk8bIFpplWo8lAdm4rNP/+Nd+r4mYvsmExIowO7m0l3zP3ROhtggmIKMPsumJT/KmilglLiyXXJIClNMFhv6oJhH+hvrOfwY1GbqKmxldwobNfTB4bPjaSONRVHcvWhCB2Yv5UdEpWlgJw6OLZAtm5DJnjovuDeQ+WnrhRNF+NjrItA4FXVqMMPntapHSB8suS+4JVOqHpsY9SQPJs7STBbfgHhcVv2G2nm+63TFo0uBOvDrlenk+4y6lkmDaYjMtaWaOKCgdRnL4oVOYBMzXbnIpRvQ/efPi4hAW9O/aPEWV77vPeSA3RNBah+XEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NdN4asqwMp+Qmk79o5em1OIXHvuz46ECWDctnAo8aI=;
 b=VQ0YPPe5jlt2ou6u8dfR1BKbpl7PNT/VXac6ewFCNtP+iE111Mg08biGHV6fFQenb47CHReEg8v0Zyjb49qubf6Pn3OxCjzx/7HnqW54Xwmje+b/UAegRm+3Brc1wp2Zz1oXXsUlyqsuVWZmFU8OYJ1WxxSW+30YoTzlTZ0XdFYkjnz+/H7+YpEYzuixjUDtEvD6Xw/lhYUGRb9xN91qTMaNQiXISt8BxFngbM3t1sHmmAuskU8ofUL99JEiBlH+GzPScPPDWPcJjnF/3Tje2C2TvFAzf92OnCBo2fe36T3OmMWI/snBL2CVn4xdUHRx24/po494a38cq7k7esqhWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NdN4asqwMp+Qmk79o5em1OIXHvuz46ECWDctnAo8aI=;
 b=jNnYdnbvSXhDCP/TlFDrKBkd+mAQfpwS3kf8mXlZxndkGxm++aH2qfkwGWAP5p/z4gzy9D4iMrSF/HozeeIgYs4ds3bcGaNxKIMM9QAvheDc82GmacL4tZ57D0LabbUWBKVRY37SGC55yg/a+2I3RS+ElpvK2whpvyp/wUQZcq1UtEh2sI0+hq/CE2OVtFYq8l4Vr+pbPlDP2lW6UKYT+4oQHSi6S2UwMzeEnnSQs/G8lEYVloKEdSeguA7xkNlC09St9dTlK69Z5NSV2C9w4IeQRWjwAiYYV0YmfMLFcjj2AiNNkHlgCG9i9RyFEkT26qhDYUNCBLho92O07OknyQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8090.namprd02.prod.outlook.com (2603:10b6:610:10a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 05:42:03 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9587.010; Thu, 5 Feb 2026
 05:42:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Long Li <longli@microsoft.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, RT <linux-rt-users@vger.kernel.org>, Mitchell
 Levy <levymitchell0@gmail.com>
Subject: RE: [EXTERNAL] [PATCH] scsi: storvsc: Fix scheduling while atomic on
 PREEMPT_RT
Thread-Topic: [EXTERNAL] [PATCH] scsi: storvsc: Fix scheduling while atomic on
 PREEMPT_RT
Thread-Index: AQHckSxbvhmgYaIv+0OErRpLCnikxbVwGj6AgABncwCAArlB4A==
Date: Thu, 5 Feb 2026 05:42:02 +0000
Message-ID:
 <SN6PR02MB41572C9E3650A6E581AA32C2D499A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
 <DS3PR21MB5735CBC7D843174F9CA9039CCE9AA@DS3PR21MB5735.namprd21.prod.outlook.com>
 <6b4933df-6af2-449c-922b-30ef8fd4c8b8@siemens.com>
In-Reply-To: <6b4933df-6af2-449c-922b-30ef8fd4c8b8@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8090:EE_
x-ms-office365-filtering-correlation-id: 4c4a9649-1eca-40ed-59b7-08de64794a18
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8062599012|15080799012|8060799015|13091999003|31061999003|19110799012|3412199025|440099028|102099032|52005399003|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HEfMMNgtVD2XOHCVx2IfNw8vW3PWp+LnSTcElMcUF4G8NAqjVQiSBhaoU+80?=
 =?us-ascii?Q?G27wsYhY5RPWRcXFTwZ7p35vrmT6BazZzgZ1/oOcj3b8Pbk2ZjPhp7D14Cjo?=
 =?us-ascii?Q?97VJbmTjYLIY8kM2EAuK1KNHmTfKwwYMuRCN4zBD2cdOIxDakQFlyXakvAxU?=
 =?us-ascii?Q?rxs44x7lMQ+nGPMgJvWsGNBZagOITq/WJ4ICa1pjeYCc61OEaRQE6Xj6ygTU?=
 =?us-ascii?Q?WejvOTuoMT0DHiMbVQXDuQB4+pke1OxlPvJwESuvWpLqAlSG+okh5deJ8UzD?=
 =?us-ascii?Q?M71/nxDW7R4FM+eZx5vOOA99i1jnhAFD535ojJ+9W4ukIolL7xzNUglnV/Cp?=
 =?us-ascii?Q?DwxQqQ/W+kMPmv2vfzLYwWwyb1wYVuUOL4/gSrnVmtmpv4PGd6ZGJ4taCNQ3?=
 =?us-ascii?Q?4EbjEtoiTc7s2vCgnUOoAw+SLIMKywoDNhn+4whVoL/LT8Imi4fYVKYZHUn2?=
 =?us-ascii?Q?PudwdcO7gptgPTNt6gWVwImMJZf3GpYKij+VozJdpzNM5ofHloY81pU3nShq?=
 =?us-ascii?Q?JrHrQhIvCSri+e0eHk8R64qjpLWXTP+mQZtT/YQD6xL7RYOpu51g31BYfiRv?=
 =?us-ascii?Q?rUM0ahCyKfrzXXzA73jVASWMtB0Ygd5fCdIgs9vuSbcESZt/DoA73ETtXW+d?=
 =?us-ascii?Q?ChCYmu4U86KQoWRxx8oTkZBUHYJE+jBe2q75ze4y6uhapq8BKiAtxVeibLDN?=
 =?us-ascii?Q?zHFc6VFa0WAmGtSuiE9rglgh9q3weKC8EvmOxeny12saBOEOGOZsurJKcL/p?=
 =?us-ascii?Q?3DykEtSiqbMUSUbExK2inzqmNP58BXPVp2T6sVj6RffaqFeKC0xC9ZbVER4p?=
 =?us-ascii?Q?RlWHwqX1KmanRHXUEssjFiMvrUvb/x5j007dCJecuxDY/tUk76Cs7hE4Xxx2?=
 =?us-ascii?Q?QXEnTBPgbOpYrrncHc9fXyplczGudfcVGi5L7SvT/RZLJVxRddP4TJcRGoLC?=
 =?us-ascii?Q?kzWa9bspoQPNHOp7ywvx20VEPY0v5/ZBWyVHlMcq9NYh9xmsIc58esLpa42W?=
 =?us-ascii?Q?HnLITecIaxQW0AmbM9Q70kLQ1O2z6EBDVQWmFWrArO8X0gvZ6UqkCMDUlE6q?=
 =?us-ascii?Q?Q4j2fafVNaMuUQbv4TU/kElvxomX88J+/Ag5lEimInnOcPKGrcSgKX8E7oBe?=
 =?us-ascii?Q?MTVQXprAvijxrycxtJ4EbCqR0k6dUKqG2vtv/TXed7Kt30qRvJTjqCytBUDY?=
 =?us-ascii?Q?yDVak2SXQrXgdgVSYOjv3V79ZXTlevUBXzWKMQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T3HEdnFKKCd5YK+wkDZ/tyKbZTFt27t+CDD0nCoip48NJOXm9e4lno9+qEKN?=
 =?us-ascii?Q?dE8ZaZCwO7qs4SWyH7P/m4Js6ZjZpe6l+GjU18AD2rDDjrKjaIDfD5RPD09x?=
 =?us-ascii?Q?jlrEM0yne6pMborUbGYFbeJeX9GWjT2jmWHOt81qkaVRsuuhHrUTOuvGyUFf?=
 =?us-ascii?Q?kcStHrY1RyS7I+4dKPZaWGGXlpvfLgI8Zp5bOQieTzHD6zEzTwQTa7PwaxDN?=
 =?us-ascii?Q?3Bmd1f5hg0eVaEp+ROeTXxWc1p9h/ExraIVihUr6ggHKbZWBCFyaw3rpCDRd?=
 =?us-ascii?Q?THFSllQV0cwQi66ydREBQ5h9N7NdfjTmkrp6QKp5h+qlu9IMRLEeZnKonPT8?=
 =?us-ascii?Q?l2gK7Ps5Ye1CBZSKmT+p7swvbnYmyPcwLeUuRvgVMk4pKMG8/0VBz/ggnL0Q?=
 =?us-ascii?Q?fZBYk0QOD0hsi57pFfqND1yaUDrclZj14Tu57YR6FJd0uFgoSfRA71i1br9B?=
 =?us-ascii?Q?BsjA9qdqqMsEGc9MRnSOQ0A9yTsK7ALOMsd+Uc2IugB8U43RsC0TEosHw6I6?=
 =?us-ascii?Q?zWXjx9uTf1U9bp956b/9pzQtOnE91xmIB3DtNuRe5yBhN4mYJUqnuD8FbGbb?=
 =?us-ascii?Q?6JCaIIhqZay2En7OKEYhjG0eWctjw8pYPHXgyEhh7FYKT5aGeaSlZs0x2ImS?=
 =?us-ascii?Q?Kl3u1PHIo4xsqlU/Ozd8WL/N7mX/0TwTHReIn7RRV3+iQRlmQcbq2wb68RLy?=
 =?us-ascii?Q?V0oAooac55KZ+W9NKygshPk6KAEYEmh3A0iESfaSq0fwf1M+ANvK1fHjWRgn?=
 =?us-ascii?Q?fzZR2IB2yeb+Cg/Fm0EaDc7ICUAZntEC67FJmYmH8UYERb1ZhhCCuUFEc1QF?=
 =?us-ascii?Q?gIIbkSiHmP8jLXtDYs0vd09/dbHuoxSoiCy/XQH3PYjlHQlCgyhZxqDHQCrs?=
 =?us-ascii?Q?USMkZ8BXdwP95PnaE/3n5DP5iXM0tVIQuF4YdwtuSx/uocTN3nLLXhjXGxqO?=
 =?us-ascii?Q?06iYAvgidlblrXWoPpAwv2b8nWzMGucRxFE0hdmlvJ4uGDA8O+SSERi8TnzF?=
 =?us-ascii?Q?+PldjhAxL3YeWtIoS3K/5BKLdl6ZW+tdxJ1Q+58PqUgGCBcrLJM5b6gQUawl?=
 =?us-ascii?Q?XxTdlGDFBXleZabUJSPuS063qYRdIaojZFF3VDq0ewwo5VEv8jMVn0CoTBNd?=
 =?us-ascii?Q?DEb/ve8ra8ayKyn1nbRhLteysZM8oeUK/iJETxlXdkC6Wy/UJ4r6d7AJGsYj?=
 =?us-ascii?Q?UXlMkSQVKeslEu5qSZyA1+djTM1kafnUSAIvzAOMWfobCjyQyAll71acXO3B?=
 =?us-ascii?Q?3TZMvJcc3DWL0OWxilqosAuWQIBS/YHUGsvOahrViKEoc9WyTnC2Dst1Jp4x?=
 =?us-ascii?Q?laIYTlOrMRAJjBJBSuDXgXYJBmsM37Xj6dfENqpdLotN3ZziDR1rSD72s0AA?=
 =?us-ascii?Q?U3GTZns9VA0fJTTEjLRvAjUsHmqL9HuPP4P00yeRdY+wmQqQx0rpV1jTTFk5?=
 =?us-ascii?Q?Di/1CnCcMYFiQqZ450vrgnwtyg+1bvZn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4a9649-1eca-40ed-59b7-08de64794a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 05:42:02.9601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8724-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,siemens.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,siemens.com:email]
X-Rspamd-Queue-Id: 8B8A4EEC68
X-Rspamd-Action: no action

From: Jan Kiszka <jan.kiszka@siemens.com> Sent: Monday, February 2, 2026 9:=
58 PM
>=20
> On 03.02.26 00:47, Long Li wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> This resolves the follow splat and lock-up when running with PREEMPT_R=
T
> >> enabled on Hyper-V:
> >
> > Hi Jan,
> >
> > It's interesting to know the use-case of running a RT kernel over Hyper=
-V.
> >
> > Can you give an example?
> >
>=20
> - functional testing of an RT base image over Hyper-V
> - re-use of a common RT base image, without exploiting RT properties
>=20
> > As far as I know, Hyper-V makes no RT guarantees of scheduling VPs for =
a VM.
>=20
> This is well understood and not our goal. We only need the kernel to run
> correctly over Hyper-V with PREEMPT-RT enabled, and that is not the case
> right now.
>=20
> Thanks,
> Jan
>=20
> PS: Who had to idea to drop a virtual UART from Gen 2 VMs? Early boot
> guest debugging is true fun now...
>=20

Hmmm. I often do printk()-based debugging via a virtual UART in a Gen 2
VM. The Linux serial console outputs to that virtual UART and I see the
printk() output in PuTTY on the Windows host. What specifically are you
trying to do?  I'm trying to remember if there's any unique setup required
on a Gen 2 VM vs. a Gen 1 VM, and nothing immediately comes to mind.
Though maybe it's just so baked into my process that I don't remember it!

Michael

