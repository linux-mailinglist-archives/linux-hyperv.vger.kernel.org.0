Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2A341E3CD
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Oct 2021 00:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhI3W1E (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 Sep 2021 18:27:04 -0400
Received: from mail-oln040093003002.outbound.protection.outlook.com ([40.93.3.2]:60797
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229573AbhI3W1D (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Sep 2021 18:27:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh44EgqpX8SDMnZeAL2lVcK7TxlJUd6Sv8elI1USRh2ok7ROS9rnhriu6ThP9L8qo1tWXB8tz2ArkGBzg+7/TvxPJeLWRiPitWppqJ0LyUXY9QXRmirN3poLFbEb00cd8uZMveevqZWwVpqGee52QQNa8+ItpsVWeg8sni7z0FzocdMTOwZfp1QgFqTSMxjo7UWkRoUS9DK/7MGKYsyYflWwB9Z5HJ4w+d9S76TA1bUZgeOWAEIykvYlVedBCrDiDJLVSxn507NwLufTnOjYMmzEKt46SshW6xfBrj9PbkNAz4tFx3MTwxVbosQrR6UOP44dKWnn+jG95te7XkFKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPN34Zicfd0t+C7meLoWFR7j67ByhOmdYDm3GrNA34Q=;
 b=GyeTwDHuWHu/oymlLWKVPwUJP2IBpI1yGzC3hNQ+v+RVt/F2kGiKSMd6pRYDajKvz7hf1UYQKMb2EDzqzo3RSv7pYTPyEMs8xVgDwvqecMKCVo8vI4urM6CTvua7dSWmQrZN7NplxbY9SoCbr8gDuEcrq0qoCdvU5ZMvpPhvh06GaYBOHTMCtoTQ14nGId4b9x1kcEm1F4gRAXrySIsFSJ/fWUvKGrDD8EYhjlOtCimoWUAt1+FsfMf0cVPLLpPEIUZmwNEM4lO//nlvVU1UwJ8lvaFFfIIwQtwmEIGxRy/ZCnvFicFZkAg/i9sJwpDJ39AbOv/thdLsA8xEp+rUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPN34Zicfd0t+C7meLoWFR7j67ByhOmdYDm3GrNA34Q=;
 b=BIuZlnE86xE2PODY+12O9qpyLD57Mjkgqnoeoz+YnHlrWloMIcny1hvjDgHSWmIbmGnTUdUSzl/S4709gQB3dbF312o/qp9pLXmb9H3snoeM8VQ55MrzCIp6VdjDaAEwhFTcPNNQYbPDTV0avxgZyUDH9x3U0/yJvZJyJmX/l9Y=
Received: from DM6PR21MB1513.namprd21.prod.outlook.com (2603:10b6:5:25c::19)
 by DM5PR21MB1847.namprd21.prod.outlook.com (2603:10b6:4:aa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.1; Thu, 30 Sep
 2021 22:25:12 +0000
Received: from DM6PR21MB1513.namprd21.prod.outlook.com
 ([fe80::5409:9351:b7d8:9fa9]) by DM6PR21MB1513.namprd21.prod.outlook.com
 ([fe80::5409:9351:b7d8:9fa9%5]) with mapi id 15.20.4587.009; Thu, 30 Sep 2021
 22:25:12 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>
Subject: RE: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Topic: [Patch v5 0/3] Introduce a driver to support host accelerated
 access to Microsoft Azure Blob for Azure VM
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqCAAAZzgIADIFJggAC3SwCAAv3hYIBE4/SggAyEiKA=
Date:   Thu, 30 Sep 2021 22:25:12 +0000
Message-ID: <DM6PR21MB15135923A4CB0E61786ABC22CEAA9@DM6PR21MB1513.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
 <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3083f4e9-5ea4-47c9-aab1-5be6659653ec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-10T02:56:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8115518e-2fd4-497e-2051-08d984612b5e
x-ms-traffictypediagnostic: DM5PR21MB1847:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB1847842322288704C9F05C55CEAA9@DM5PR21MB1847.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0dil3QMDWQqL6IyJ442JbzGw0lMYkGSDthFB3Se262QEjKTmIl1QiG23nAUNA9tRAPWynt6MhHRMmWbBTgLCs8/BaAu/eLCt4/8tq0MfEYptg7FnimC3MSFLkGlpfWFk7sBQoNvjOiJVwTZpm3st6q6/KGoNB9i8/wKYzZKuRUeOcWFkTrnHVI/6szym34EARSotJaWgMt+aO+m/NEGTUGazLg6b4940tgdB+Hu+7AmFk94XCXbCm+HizLSPzkxkimrAXWzgrwircW6tcqx9TkKNRh/uyPJgCMDkU/pCXQVH+48e/+zK1v2bMB4LT1RqF5yvJtxle9u4oAty/qcfWz0zgDI+3JbVECyZQOYBMphffrzo8d2I9afomb8o+si8/CDTQyT57zNbAok/PkAAsWDId1tWjVczTXEdaym5d5Gj9k13IvJuCR5ASOl1nonc/NOBfLS3Ga9kBMqybcVLCqbUgru6GlAIG7EToxxaYunEmckPZmbrlHDUjqyBKMg7cuQuga9nRKXh79I4u/mEOkpUtx1oa8KsVvsfjtuZgyIxq/jM1wI5hrUcqdxqnJaLn/drHL9tEEd2Pp/lIvMkwDhlJOugkk3BEiQ8jo3G/gHowI+8BDkZYGrD1kKwH7AoOdw+wDBd1/X5Y5Q4/tNRXgkzRmddG9Be8ZJPUaPreOt5S+ABG4A8hqt/jT3qp15On7sAxLAmyhl61v564nWU3maWuXPAOIgR5xBcmQ2SdbtiiM5wp7QHGWoSGu2wfc0JRBFUoDYWgdLBa9ElKGiYlOvtV/fTqqewsJ8aQAlROIcySb26cUhqZv9Hi8rX+rFazxAv99d8VOAlTpOATgfx0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1513.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(66946007)(71200400001)(2906002)(66556008)(8676002)(76116006)(9686003)(7416002)(82960400001)(82950400001)(8936002)(26005)(52536014)(7696005)(38070700005)(66476007)(316002)(83380400001)(6506007)(55016002)(4326008)(5660300002)(8990500004)(966005)(33656002)(54906003)(508600001)(86362001)(186003)(66446008)(64756008)(122000001)(6916009)(38100700002)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A7V6JVBeg1a0wa+lj8y4aU7qGEChC7IZ+A9MRrHRwU5kkn5XvkJLKOMnxZqb?=
 =?us-ascii?Q?qyIkJY92zhe4qXBdtB3dOTryGIeUlXPva+hejKoK4jwXJurlzM+HTI18RSP3?=
 =?us-ascii?Q?MIC6OcixDXxJDRzCwVHLxcZoH+KFd5bSk1WyFH+LoMBfRadLyt0GavWT4LXW?=
 =?us-ascii?Q?4jd0Ug2KnYyq0icBWqxCFZ+tDOfPkm1aTa2TjrRrT8NTjqQJINVgoI+TDkIp?=
 =?us-ascii?Q?2fFQSBNdr6mDD5SXeE85oyM5TJKBTlCWqkWZbSUJmw2Phf1UVAzFjoSFTYTl?=
 =?us-ascii?Q?myDjCUC0HIR1b768BVu9Tm8sQ5+NuQgIychdnFchkgGqTF6WWm2vYkChFrVJ?=
 =?us-ascii?Q?VSDrWnAKKI0CCPWn74uKt19YkE+zIgoUqSDR+Uszqkkz45vWPL5UQqNlGQzN?=
 =?us-ascii?Q?MYsfUI5dLlmXSLpCBcVqbbwlSCTxexoGAIXwK9GfNhYJb0rnUkShqykOfyuV?=
 =?us-ascii?Q?1HJWQzJBECwCrisi6Dz7D8O3cQKDdNYsQXIqB8cKW+hHhl2phlqExAv4kQcP?=
 =?us-ascii?Q?hDqwxVuCvGSUaWiKKbYc6gR2DwQ0metsInYTykmxnbqQe03ZQVoMcOxOnz7X?=
 =?us-ascii?Q?puEZQALE2oQpy0IOdLC0LlQa/56RCIHR7NG5uZYODJ8Sq3+SftnPNdWpJEOu?=
 =?us-ascii?Q?RBVAJyflss6M5nTApJ/lBEmVn11sh1XpnMRCcOTLOq2uJewDW5hRTf43vtos?=
 =?us-ascii?Q?frBxSpZ0BimA4y3V0axQIf5IRvkrasEuyOng2yYiq7UzhiYHpODb2aTIwwI2?=
 =?us-ascii?Q?6PGtJRAjdvVk216+Z0H5e3YqAH0zhZcbD3/HNSmk0XE6HAKxEMjUOIy1sFuD?=
 =?us-ascii?Q?i8sEX8tMs3p2HqEFGFEUSPMTlverrOCUKH559kb4BK1Qt7HQqeIblLhQGTht?=
 =?us-ascii?Q?ToEJB0BriLNE4lKU3yuhP87+MMgE7rQfwvorTFC4Z6ZNTLKTdn2p4fSfTOYw?=
 =?us-ascii?Q?w2v39z1AwW1aXuSgW44lRhJ4QJ34TVWVy/bXBW/LxOwLbYSGBDWWgbKjGosi?=
 =?us-ascii?Q?50h32AOh9DLggzR9qulcCdjUxA9XHCv3amgNcNjHiniBF481JuWgu/LRb+13?=
 =?us-ascii?Q?eABKc3pgY+4iQwF64n3LC8ELoSynrY93VIh8uAdIywk8Y+KJPJ4+l0Dt2M95?=
 =?us-ascii?Q?3yxXD8UCsGixfdlTvXaE73dq2HaqgtUfwTL1V0PbZnvVOLP34Mm7+JrbZ6SW?=
 =?us-ascii?Q?jfXRsuNO0PDNzNc7EdXC9ALIDF65Wet+DK/Joi3htTsx1lqi8JieR/6IXbbi?=
 =?us-ascii?Q?e4/lI1yLulgiH7UrA4VNyVzpQACopn9RQ1OxBw27d+hG0aewJOwOrInkfjDJ?=
 =?us-ascii?Q?YBF5HajX2uMvq1Z6aD8jvy5A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1513.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8115518e-2fd4-497e-2051-08d984612b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 22:25:12.1887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rL1vQmeUyePh2Uwrpoq9uII3Wrt45ceBhOAZia12nM2IP1sZOsT+OWDBAaL5kXMfxSFSqK311pSNc0ytyg/KPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1847
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v5 0/3] Introduce a driver to support host accelerate=
d
> access to Microsoft Azure Blob for Azure VM
>=20
> > Subject: RE: [Patch v5 0/3] Introduce a driver to support host
> > accelerated access to Microsoft Azure Blob for Azure VM
> >
> > > Subject: Re: [Patch v5 0/3] Introduce a driver to support host
> > > accelerated access to Microsoft Azure Blob for Azure VM
> > >
> > > On Sat, Aug 07, 2021 at 06:29:06PM +0000, Long Li wrote:
> > > > > I still think this "model" is totally broken and wrong overall.
> > > > > Again, you are creating a custom "block" layer with a character
> > > > > device, forcing all userspace programs to use a custom library
> > > > > (where is it
> > > at?) just to get their data.
> > > >
> > > > The Azure Blob library (with source code) is available in the
> > > > following
> > > languages:
> > > > Java:
> > > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > gi
> > > > th
> > > > ub.com%2FAzure%2Fazure-sdk-for-
> > > java%2Ftree%2Fmain%2Fsdk%2Fstorage%2Faz
> > > > ure-storage-
> > > blob&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C778083147
> > > >
> > > 8ed49b16e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1
> > > %7C0%7C6
> > > >
> > >
> 37639965101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > > DAiLCJQIjoi
> > > >
> > >
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DwcNhsEo
> H
> > > LV0VBc
> > > > uDf0CVXl7W0Ug9Cj7Q92%2Bw6qizroU%3D&amp;reserved=3D0
> > > > JavaScript:
> > > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > gi
> > > > th
> > > > ub.com%2FAzure%2Fazure-sdk-for-
> > > js%2Ftree%2Fmain%2Fsdk%2Fstorage%2Fstor
> > > > age-
> > >
> blob&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C7780831478ed49b
> > > 16
> > > >
> > > e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C
> > > 637639965
> > > >
> > >
> 101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj
> o
> > > iV2luMzIi
> > > >
> > >
> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DI%2FfhdPX3Unz6S
> 3
> > > eBPcpl
> > > > %2Bh55nKoV0u%2FO0%2BYgjLy4grQ%3D&amp;reserved=3D0
> > > > Python:
> > > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > gi
> > > > th
> > > > ub.com%2FAzure%2Fazure-sdk-for-
> > > python%2Ftree%2Fmain%2Fsdk%2Fstorage%2F
> > > > azure-storage-
> > > blob&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C7780831
> > > >
> > > 478ed49b16e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7
> > > C1%7C0%7
> > > >
> > >
> C637639965101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > > MDAiLCJQIj
> > > >
> > >
> oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DaAwsi%
> 2
> > > BPVsN
> > > > tsDMJ7rKnRDigNc41fIao031lde247Nc0%3D&amp;reserved=3D0
> > > > Go:
> > > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > gi
> > > > th
> > > > ub.com%2FAzure%2Fazure-storage-blob-
> > > go&amp;data=3D04%7C01%7Clongli%40mic
> > > >
> > >
> rosoft.com%7C7780831478ed49b16e6308d95a2b7ae8%7C72f988bf86f141a
> > > f91ab2d
> > > >
> > >
> 7cd011db47%7C1%7C0%7C637639965101378114%7CUnknown%7CTWFpbG
> > > Zsb3d8eyJWIj
> > > >
> > >
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 0
> > > 00&am
> > > >
> > >
> p;sdata=3D43JhbGsYQxA%2FoivNd7C3z7DSYO%2FPONCoaW2v7TN6xEU%3D&a
> > > mp;reserve
> > > > d=3D0
> > > > .NET:
> > > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > gi
> > > > th
> > > > ub.com%2FAzure%2Fazure-sdk-for-
> > > net%2Ftree%2Fmain%2Fsdk%2Fstorage%2FAzu
> > > >
> > >
> re.Storage.Blobs&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C77808
> > > 3147
> > > >
> > > 8ed49b16e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1
> > > %7C0%7C6
> > > >
> > >
> 37639965101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > > DAiLCJQIjoi
> > > >
> > >
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6ClMeURl
> t
> > > cBv1q
> > > > 7l7PGGrxXVJbVDt9uMBlwoIVh7Wpw%3D&amp;reserved=3D0
> > > > PHP:
> > > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > gi
> > > > th
> > > > ub.com%2FAzure%2Fazure-storage-php%2Ftree%2Fmaster%2Fazure-
> > > storage-blo
> > > >
> > >
> b&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C7780831478ed49b16
> > > e6308d9
> > > >
> > > 5a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6376399
> > > 651013781
> > > >
> > >
> 14%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM
> zIi
> > > LCJBTiI
> > > >
> > >
> 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DDuZO539vd76c%2Byaqjn
> > > hetp%2B3T
> > > > i0b74601ZkNe39SNK4%3D&amp;reserved=3D0
> > > > Ruby:
> > > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > gi
> > > > th
> > > > ub.com%2Fazure%2Fazure-storage-
> > > ruby%2Ftree%2Fmaster%2Fblob&amp;data=3D04
> > > > %7C01%7Clongli%40microsoft.com%7C7780831478ed49b16e6308d95a2
> b
> > > 7ae8%7C72
> > > >
> > > f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637639965101378114%7
> > > CUnknown%
> > > >
> > >
> 7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wi
> > > LCJX
> > > >
> > >
> VCI6Mn0%3D%7C1000&amp;sdata=3D6Zviu1IuRQE2do9bDCae2iJv0W2KOJu90t
> > > XSR6kDAR
> > > > 4%3D&amp;reserved=3D0
> > > > C++:
> > > >
> > >
> C++https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2
> > > C++Fg
> > > > C++ithub.com%2FAzure%2Fazure-sdk-for-
> > > cpp%2Ftree%2Fmain%2Fsdk%2Fstorage
> > > > C++%23azure-storage-client-library-for-
> > > c&amp;data=3D04%7C01%7Clongli%40m
> > > >
> > >
> C++icrosoft.com%7C7780831478ed49b16e6308d95a2b7ae8%7C72f988bf86
> > > f141af9
> > > >
> > > C++1ab2d7cd011db47%7C1%7C0%7C637639965101388074%7CUnknown%
> > > 7CTWFpbGZsb3
> > > >
> > >
> >
> C++d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn
> > > 0%3
> > > >
> > >
> C++D%7C1000&amp;sdata=3DHH6jrqREWQ%2BkoRR%2Fsb02wRXnuLU5il4Erzm
> > > rBvUZu5w%
> > > > C++3D&amp;reserved=3D0
> > >
> > > And why wasn't this linked to in the changelog here?
> > >
> > > In looking at the C code above, where is the interaction with this Li=
nux
> driver?
> > > I can't seem to find it...
>=20
> Greg,
>=20
> I apologize for the delay. I have attached the Java transport library (a =
tgz file)
> in the email. The file is released for review under "The MIT License (MIT=
)".
>=20
> The transport library implemented functions needed for reading from a Blo=
ck
> Blob using this driver. The function for transporting I/O is
> Java_com_azure_storage_fastpath_driver_FastpathDriver_read(), defined
> in "./src/fastpath/jni/fpjar_endpoint.cpp".
>=20
> In particular, requestParams is in JSON format (REST) that is passed from=
 a
> Blob application using Blob API for reading from a Block Blob.
>=20
> For an example of how a Blob application using the transport library, ple=
ase
> see Blob support for Hadoop ABFS:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> ub.com%2Fapache%2Fhadoop%2Fpull%2F3309%2Fcommits%2Fbe7d12662e2
> 3a13e6cf10cf1fa5e7eb109738e7d&amp;data=3D04%7C01%7Clongli%40microsof
> t.com%7C3acb68c5fd6144a1857908d97e247376%7C72f988bf86f141af91ab2d7
> cd011db47%7C1%7C0%7C637679518802561720%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C1000&amp;sdata=3D6z3ZXPtMC5OvF%2FgrtbcRdFlqzzR1xJNRxE2v2Qrx
> FL8%3D&amp;reserved=3D0
>=20
> In ABFS, the entry point for using Blob I/O is at AbfsRestOperation
> executeRead() in hadoop-tools/hadoop-
> azure/src/main/java/org/apache/hadoop/fs/azurebfs/services/AbfsInputStr
> eam.java, from line 553 to 564, this function eventually calls into
> executeFastpathRead() in hadoop-tools/hadoop-
> azure/src/main/java/org/apache/hadoop/fs/azurebfs/services/AbfsClient.ja
> va.
>=20
> ReadRequestParameters is the data that is passed to requestParams
> (described above) in the transport library. In this Blob application use-=
case,
> ReadRequestParameters has eTag and sessionInfo (sessionToken). They are
> both defined in this commit, and are treated as strings passed in JSON fo=
rmat
> to I/O issuing function
> Java_com_azure_storage_fastpath_driver_FastpathDriver_read() in the
> transport library using this driver.
>=20
> Thanks,
> Long

Hello Greg,

I have shared the source code of the Blob client using this driver, and the=
 reason why the Azure Blob driver is not implemented through POSIX with fil=
e system and Block layer.

Blob APIs are specified in this doc:
https://docs.microsoft.com/en-us/rest/api/storageservices/blob-service-rest=
-api

The semantic of reading data from Blob is specified in this doc:
https://docs.microsoft.com/en-us/rest/api/storageservices/get-blob

The source code I shared demonstrated how a Blob is read to Hadoop through =
ABFS. In general, A Blob client can use any optional request headers specif=
ied in the API suitable for its specific application. The Azure Blob servic=
e is not designed to be POSIX compliant. I hope this answers your question =
on why this driver is not implemented at file system or block layer.

Do you have more comments on this driver?

Thanks,
Long


