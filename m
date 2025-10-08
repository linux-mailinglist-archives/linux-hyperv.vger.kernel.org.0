Return-Path: <linux-hyperv+bounces-7141-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3763EBC59F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Oct 2025 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 939024F6B19
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Oct 2025 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BC02F39B9;
	Wed,  8 Oct 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jmLrvFdl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010017.outbound.protection.outlook.com [52.103.23.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60B29D275;
	Wed,  8 Oct 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937457; cv=fail; b=aRVDiegt8K3ql9hclci//S19hGWHwNfmdUWikNUAQ6awC5D+DWS5G6Xd6ZD/jVlF+YURtLou2oPiOdgbYrJBWqVf8t5oj6wn5oeHfjP6B2kxU9yp33xZ0Qsr1V+TGh15706JCzNb2J4kB2hY4f6xrTFCLAKGvFI/qYn8cT5AL+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937457; c=relaxed/simple;
	bh=EX4obtjCPWL5B5CeXhOmQoK8R/QAdJZ5td/IErRlUDE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=URzNtm6tmNKapKh3TsMtplclEtGKEbqi7FzXuScHSV7tWR6OX1FZyt0w7MJAZQib7nMbM3PQh3g2yvY5gShGzr6EbhJHrTKkPeLJP1nbcXx2YbELgz0IHFCGN48F/7SdnvI5xXaGL0EkhgYSIcMEf+22FMFGqG97mWxlEoLgh4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jmLrvFdl; arc=fail smtp.client-ip=52.103.23.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3k37M21hdESVt8GUwToZrGvU1m0W03b4NTRFtHhAbwGL5EJZ1MjrB1RmTBaUu+rTay0G+r2btydo1cCb4iC9LSqe6YeyKeSKpNnZhFqCVGYpo5HGMzrs2gzlUqdBEXSBBJAG8XXnqERhbw530X6RwBhwfIj/CuZAN7JZKufbE6fHb8sme+4JuDnOKXlqsE8wA/IeGKLwMd4/omaIIW47j0P2B70CSFGihr1cGqRZw0b41Yn8qEgTBCeIGB7KEgoEaWCgabfiNApoVaKqnuhS/mZmr1E7I5mENZJAs3gy2slM7DDynPtP5mj3can6W4rsVgOUcYwKNO2eHilPmuzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKnEzrqudtR/U9fv9FT6TO17qJwuT3X3pi3qnClB0TQ=;
 b=OjKCzN0MPzUFGekqqnpi64Wrses/kibeL9CbCVPm5nLk7oIianUuO9K1+O/xOpn3n5qU2inztr45AYn/ptwMIWKQL1O5BfZ87FFZSZB41kKAcJ/7OiJGHTfZpFtF9F5iLgZ57KiInezwnErB0F5ENtc8RPd5/WhzWeCt9IonFIYQKJkX5AIUtxUNgBBIYRt1Xn2SlGw+J6A0l8QHuH8tZapkrQxCafyYydIGORc13LeVehNpfPadIBbTlkOPUWrU5mSDxeMO2+5GlGJh0EVtJHokGxnWiJEcoM5qFGhzDDlwZq9UZJUjw7ayZ8pWQjVK8F9/X60c7As1K6BiiLWWqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKnEzrqudtR/U9fv9FT6TO17qJwuT3X3pi3qnClB0TQ=;
 b=jmLrvFdlGsuSaeAwE2CyQwWOpA/hCMr/rf/U7t9o5NFo1/hwKr7Hszfz6LryD4i/mnWxR9fRBnII3lw1tHItykSBFL6ivPktT1dvKn9bh98aw1vGs8Gm2AHK8ulcUhYBh+DOqHKnps5p2tLBBe2ZTKEf93KabdJ+4k/La7IA/csNgIpb8G6LPc4XAkFNbbvY6cmQkuARO9GEWbdfUeiDr9reN0xZLa6q8Yw9bRyCWg8kHrdOHtL3gfVleYsGV7w5vWl/UcTkewaxRo0b4StfaH+QRMRzOyXzt151BzFDZiAHrM0SfaMe5AP65t2XO7IAYip2entrO7rnnlYseu8CoQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6671.namprd02.prod.outlook.com (2603:10b6:208:1d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 15:30:51 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 15:30:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, "longli@linux.microsoft.com"
	<longli@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, James Bottomley <JBottomley@Odin.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: storvsc: Prefer returning channel with the same CPU
 as on the I/O issuing CPU
Thread-Topic: [PATCH] scsi: storvsc: Prefer returning channel with the same
 CPU as on the I/O issuing CPU
Thread-Index: AQHcM1o80XmWhpePUEiNmnbV/dytobS20liAgACjkICAAO2BEA==
Date: Wed, 8 Oct 2025 15:30:51 +0000
Message-ID:
 <SN6PR02MB4157F816858A01D480FB203ED4E1A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1759381530-7414-1-git-send-email-longli@linux.microsoft.com>
 <SN6PR02MB4157B7FC3362C4C6838BAD3DD4E0A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DS3PR21MB573566DF7A81D555552DE8A7CEE1A@DS3PR21MB5735.namprd21.prod.outlook.com>
In-Reply-To:
 <DS3PR21MB573566DF7A81D555552DE8A7CEE1A@DS3PR21MB5735.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1cf71a9b-5da0-4d36-8afb-a428d2ab4a7e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-10-07T23:58:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6671:EE_
x-ms-office365-filtering-correlation-id: 5e9a0b0a-c02a-47ef-6495-08de067faa15
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|8060799015|13091999003|8062599012|41001999006|19110799012|12121999013|15080799012|3412199025|440099028|40105399003|13041999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Mxpl4+SoYBwcouGbw8ueJooepwIkzr5rYZt7MS0zigQKKvxxrNWjxLqopMYD?=
 =?us-ascii?Q?Ks6jdukPpzb/2ZbyV0Lvl5omMY3JhmeTioB1oxrkIgbgoM+gAi6XsnKww5Vn?=
 =?us-ascii?Q?WamI5JylgZD3FpkD9XHkzCxsDqt+n2x7rK85JmqSjeWbd0UMJvkekPa3StMd?=
 =?us-ascii?Q?h7Pk3olbXaMAV/6wbILX0EXi7iUBwubEO9IhbIwzdzvkzjeuclOVya0ju8jw?=
 =?us-ascii?Q?j5kHfM+MoEdHQ1SdeCqBiBxw4djXiU7V2Ov8S+UUxeoZ3Y2DKoaM6+RVq2sY?=
 =?us-ascii?Q?I6D6E7B59hCrWsneTJEGrEtRezMLWJL61v/s1z13aj0wlufeQv1JCb4iu/hv?=
 =?us-ascii?Q?SBNjl+O+AudSK3eduMIvV8IE5TbHTcumgFiiGALkDJe4IjAm9DB1g9IbxV3k?=
 =?us-ascii?Q?Y16Al+xVpVrvi9QhxM91Zo0kR/Z7rG4o63mhcKCba5WG2Xr9+sInzIaU8VNa?=
 =?us-ascii?Q?ADxX3bKeOMonMpZBPNfUMCFDmoyNQhQY9aZq3Fe/tS7syzziA4MjbPKpGgch?=
 =?us-ascii?Q?H9G/bmcgH11m2fcKHQZldQUMJ6fE9LMEyvcAkdBelrEzMZo+V/Ry4q4ks6D+?=
 =?us-ascii?Q?JiPiXVxOT2rjlVeppmIcYLYKC78kDSCKcB7w04B0VRig8ocIisrJ+Vayu5Kl?=
 =?us-ascii?Q?ZBQSSqaHFqROCcbb6BI0lL8OlSpDufBIUc1tN5btwR9tER6QqAy29d4SCpqE?=
 =?us-ascii?Q?FWFDXZBqKUjC5WTFp90gDkTp4yL4nfkfvaM6n/QxWqL6Us67NcysbE4VC+ng?=
 =?us-ascii?Q?7GuEXWCct6/ryj+Bxy3wUhhLUqGmv0Gzk/s6rkdgEIXX/e1J7ydXd2n0N/aQ?=
 =?us-ascii?Q?1PxP+Ul8KSsdXxZD0huRMWNrANm8QJoQv7PvD3qNYsM28xe3hGdVFzcyGQDd?=
 =?us-ascii?Q?sLDufUovo5yua3CJS5BqBsonsOWq94ijbWG7iQeTRD4QMlofE7FK7cpNvHMd?=
 =?us-ascii?Q?OKsmL+8P2Exv/SsRAO+OHNDRtEZcORdmhx/bIfK5NwxbbZOUXfN47cxleGr4?=
 =?us-ascii?Q?F4o6ydYovw+YOjMtDO+yFcJLLb6H8nHO0H9RLQ0kHRtVL5k2Z+qAPai1zl8x?=
 =?us-ascii?Q?gja7qKm/ziqBWKSFMLK3FunN2Y2KY23ZNDUKcOwNY0HyQnGSIOwUAFEGGORy?=
 =?us-ascii?Q?LD/G+NyQRmxWJW4agmX0UEmyvz9wqZpU6XATLXFd38VybOhQUxGq0j20ZtH7?=
 =?us-ascii?Q?4IvkrPzv3v8uYj8MSqLeaXZbCyaFgxutciLPIDL63VpdT9VNGIWY1D+zPocn?=
 =?us-ascii?Q?alpWMorTpl08ESuY5cbjZgfMlUkwE1cyLQXuhYGMYw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K+/iSsDqn6bCujdsONIaWw2DIds0zE8GT2UglVwYD/5oAVcbmIeDqJWlINPQ?=
 =?us-ascii?Q?GxJ9ka7tqJOv/p8bqZAuanec4S7tCBm4V70nc3BTaaa7PH1wKb6hIJA0qswn?=
 =?us-ascii?Q?6mOCZbWBu5x00LP6rhn4og+EvDcDg5ropo2TtqP8qaRmawrMQ4z2i1xJPmR0?=
 =?us-ascii?Q?3p86YJnnLI+i7PaMqTlHzdyAbdddEpeRKnFyHZa39aQZNouJN2hi54wj1S4Y?=
 =?us-ascii?Q?/hSYArajzu7h1TX1dZq5RzzPTLj5FaHbwx59Yc76x4h++568VaA52wJBH/DL?=
 =?us-ascii?Q?Z2mhEhPU6m1zvLs8anp9Y3Lysb71SNa/EvoWMRVOEgXu3dQI8cIdNV6EkuxN?=
 =?us-ascii?Q?P+ipepG0xsDPYuJt6vF68yHdCT4z/FRC09vXy1aq5ddFjw2iuHbjpW4QsKoh?=
 =?us-ascii?Q?U94ghRhUCjx23SDNkdXnmAtJ6IDH2NC5rtC9reOJNagI7x3NTrz4JHTBc7ew?=
 =?us-ascii?Q?S1MlaAUTMtSBy1ZEw5FT7QpjnAsm8b2IzfOa4pjbxzbpQSRnc3OkS+RvO4OR?=
 =?us-ascii?Q?kUTVVr1XzXVNwRn6Y4AODUyzO6K7I+Oji0rj5pAX50VWRNNBgck4gXYBnAJx?=
 =?us-ascii?Q?8RJCv9BhwmTlAN+cMN/3o6RfMwXmPwMInasyIspbjRjMgwiU6NzZ9AptQxC1?=
 =?us-ascii?Q?zLLnQsEqzUp1cS558cjgvJ0OZyue950rBuwqVbChFSO1Fk9di8t/qbyOHn7n?=
 =?us-ascii?Q?KFgDT5XhsY0TwyFyf3CD8MS66lI49bBNh0Q4mQ+3uHFnY7hTLiU9KhH7B7Oa?=
 =?us-ascii?Q?J1aWi7cUQhEIFolPIbBCVlSUWmbYFEjjuJ+mJOgXrwVb/UMFNv7efDKAx6Cu?=
 =?us-ascii?Q?sGFEBbaJ0dyOC/yQSHyJWLBLJf9B9MBwC6Henvp12ujTxNZc2vKk8bGgUdsK?=
 =?us-ascii?Q?6MKzepZAQ3H2dhk0kTODbSlmbhMnHR8kLG/BzCYR4Acy1vsClJuyJNQERLzb?=
 =?us-ascii?Q?q56dSzJkTY2URXrtm9P1LQbqScurh+/Kng+gP2ftPRaAmiRWRCndAhSzNfUB?=
 =?us-ascii?Q?8g9C1aCFQ74t/LQWcRGTf8+qYCh4Q4Hc0UXHP65vjIG6qzQlQ1XSPmGVSQTo?=
 =?us-ascii?Q?eWircoVCP1a8RCvFj13ZY8PVpS6r4aN8TwsNWAOF7csHMX2u7yJZVN9GnoLz?=
 =?us-ascii?Q?IMuu1b/s18pWyoKxeOYdvK8zjOEPK/XORHzhfkwWhuw5Xx5m+CVYYSn8ortu?=
 =?us-ascii?Q?//VaOeKSJJhYxZirPXg8yPJGljPDpwOvGPiVQQ4+EcpM0WP9eMpbJg01/H8?=
 =?us-ascii?Q?=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9a0b0a-c02a-47ef-6495-08de067faa15
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 15:30:51.6745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6671

From: Long Li <longli@microsoft.com> Sent: Tuesday, October 7, 2025 5:56 PM
>=20
> > -----Original Message-----
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Tuesday, October 7, 2025 8:42 AM
> > To: longli@linux.microsoft.com; KY Srinivasan <kys@microsoft.com>; Haiy=
ang
> > Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>; Dexuan Cu=
i
> > <decui@microsoft.com>; James E.J. Bottomley
> > <James.Bottomley@HansenPartnership.com>; Martin K. Petersen
> > <martin.petersen@oracle.com>; James Bottomley <JBottomley@Odin.com>;
> > linux-hyperv@vger.kernel.org; linux-scsi@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: Long Li <longli@microsoft.com>
> > Subject: [EXTERNAL] RE: [PATCH] scsi: storvsc: Prefer returning channel=
 with the
> > same CPU as on the I/O issuing CPU
> >
> > From: longli@linux.microsoft.com <longli@linux.microsoft.com> Sent:
> > Wednesday, October 1, 2025 10:06 PM
> > >
> > > When selecting an outgoing channel for I/O, storvsc tries to select a
> > > channel with a returning CPU that is not the same as issuing CPU. Thi=
s
> > > worked well in the past, however it doesn't work well when the Hyper-=
V
> > > exposes a large number of channels (up to the number of all CPUs). Us=
e
> > > a different CPU for returning channel is not efficient on Hyper-V.
> > >
> > > Change this behavior by preferring to the channel with the same CPU a=
s
> > > the current I/O issuing CPU whenever possible.
> > >
> > > Tests have shown improvements in newer Hyper-V/Azure environment, and
> > > no regression with older Hyper-V/Azure environments.
> > >
> > > Tested-by: Raheel Abdul Faizy <rabdulfaizy@microsoft.com>
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > >  drivers/scsi/storvsc_drv.c | 96
> > > ++++++++++++++++++--------------------
> > >  1 file changed, 45 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> > > index d9e59204a9c3..092939791ea0 100644
> > > --- a/drivers/scsi/storvsc_drv.c
> > > +++ b/drivers/scsi/storvsc_drv.c
> > > @@ -1406,14 +1406,19 @@ static struct vmbus_channel *get_og_chn(struc=
t storvsc_device *stor_device,
> > >  	}
> > >
> > >  	/*
> > > -	 * Our channel array is sparsley populated and we
> > > +	 * Our channel array could be sparsley populated and we
> > >  	 * initiated I/O on a processor/hw-q that does not
> > >  	 * currently have a designated channel. Fix this.
> > >  	 * The strategy is simple:
> > > -	 * I. Ensure NUMA locality
> > > -	 * II. Distribute evenly (best effort)
> > > +	 * I. Prefer the channel associated with the current CPU
> > > +	 * II. Ensure NUMA locality
> > > +	 * III. Distribute evenly (best effort)
> > >  	 */
> > >
> > > +	/* Prefer the channel on the I/O issuing processor/hw-q */
> > > +	if (cpumask_test_cpu(q_num, &stor_device->alloced_cpus))
> > > +		return stor_device->stor_chns[q_num];
> > > +
> >
> > Hmmm. When get_og_chn() is called, we know that stor_device-
> > >stor_chns[q_num] is NULL since storvsc_do_io() has already handled the=
 non-
> > NULL case. And the checks are all done with stor_device->lock held, so =
the
> > stor_chns array can't change.
> > Hence the above code will return NULL, which will cause a NULL referenc=
e when
> > storvsc_do_io() sends out the VMBus packet.
> >
> > My recollection is that get_og_chan() is called when there is no channe=
l that
> > interrupts the current CPU (that's what it means for stor_device-
> > >stor_chns[<current CPU>] to be NULL). So the algorithm must pick a cha=
nnel
> > that interrupts some other CPU, preferably a CPU in the current NUMA no=
de.
> > Adding code to prefer the channel associated with the current CPU doesn=
't make
> > sense in get_og_chn(), as get_og_chn() is only called when it is alread=
y known
> > that there is no such channel.
>=20
> The initial values for stor_chns[] and alloced_cpus are set in storvsc_ch=
annel_init() (for
> primary channel) and handle_sc_creation() (for subchannels).

OK, I agree that if the CPU bit in alloced_cpus is set, then the correspond=
ing entry in
stor_chns[] will not be NULL.  And if the entry in stor_chns[] is NULL, the=
 CPU bit in
alloced_cpus is *not* set. All the places that manipulate these fields upda=
te both so
they are in sync with each other.  Hence I'll agree the code you've added i=
n get_og_chn()
will never return a NULL value.

(However, FWIW the reverse is not true:  If the entry in stor_chns[] is not=
 NULL, the
corresponding CPU bit in alloced_cpus may or may not be set.)

>=20
> As a result, the check for cpumask_test_cpu(q_num, &stor_device->alloced_=
cpus) will
> guarantee we are getting a channel. If the check fails, the code follows =
the old behavior
> to find a channel.
>=20
> This check is needed because storvsc supports change_target_cpu_callback(=
) callback
> via vmbus.

But look at the code in storvsc_do_io() where get_og_chn() is called. I've =
copied the
code here for discussion purposes. This is the only place that get_og_chn()=
 is called:

                spin_lock_irqsave(&stor_device->lock, flags);
                outgoing_channel =3D stor_device->stor_chns[q_num];
                if (outgoing_channel !=3D NULL) {
                        spin_unlock_irqrestore(&stor_device->lock, flags);
                        goto found_channel;
                }
                outgoing_channel =3D get_og_chn(stor_device, q_num);
                spin_unlock_irqrestore(&stor_device->lock, flags);

The code gets the spin lock, then reads the stor_chns[] entry. If the entry=
 is
non-NULL, then we've found a suitable channel and get_og_chn() is *not*
called. The only time get_og_chan() is called is when the stor_chn[] entry
*is* NULL, which also means that the CPU bit in alloced_cpus is *not* set.
So the check you've added in get_og_chn() can never be true and the check
is not needed. You said the check is needed because of=20
change_target_cpu_callback(), which will invoke
storvsc_change_target_cpu(). But I don't see how that matters given the
checks done before get_og_chn() is called. The spin lock synchronizes with
any changes made by storvsc_change_target_cpu().

Related, there are a couple of occurrences of code like this:

                for_each_cpu_wrap(tgt_cpu, &stor_device->alloced_cpus,
                                  q_num + 1) {
                        channel =3D READ_ONCE(stor_device->stor_chns[tgt_cp=
u]);
                        if (!channel)
                                continue;

Given your point that the alloced_cpus and stor_chns[] entries are
always in sync with each other, the check for channel being NULL
is not necessary.

Michael

