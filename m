Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF2415445
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Sep 2021 01:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbhIVX5P (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Sep 2021 19:57:15 -0400
Received: from mail-eastus2namln1000.outbound.protection.outlook.com ([40.93.3.0]:41046
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230412AbhIVX5O (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Sep 2021 19:57:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muxNMVHiuSLGb58En52MeVbAFI1scEHpPL3NadCgFZwFWz2425MKJH+4d6RgswS2Tx095+R0B6fO2BErZjM6TNvygsgoqv9F9Yg5aDsKbB5CS4By7VS8isyfhLNY8Mac51wc+0e37qSRFG9zWwhk7kqoMxJ9YprcBFEa8wAiIYLYaztKaFz2T0sN6beGjMuRtCJTyowPsaK1+UtSgktGWXFkFj4XK+UtRL5vWc6hPWju3izWEbQMCRNLJ5xJtIp8GpsHJUb4uBTJ3UWyYCu+8RIbVWVykNpnR+qgE6WdOx6GnrNnbLyqW2wiZRgoZY5KH6OYlLuq3mUjy4h6FqXQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pcrgzyy8oNqEXZdE/0w7rUhxHgybqf0c2WdYe0WXvZo=;
 b=RFkELgK+9z017aLTGiaNxrd4yI/auEltO7nusD0VkVWQPGe/sZUtDa1dZvFKYR/jdcObj/dsr+igraGAI9z97kJTIgFqyZ2txEsrjS85/M9E4kyBtPzRkJkwnTuu1MUb6mzP0ESJVWQ6oDbHXFPwX2ZfcE4fJdTEOUbB59EaX1WZEULKo1GTEKJhjleZhXAhZvaEd6qjbqhNk2zFT3fqVkqwXyojqAcMXsIKHgPFHrSsLMvId2CSsMUmZTquwWbQBZ1SpwOB7FWqRxg3zB+Es931GgSUrjYbCipK66nRshHb5idZ2LSQ/tej7+bkOkgo5jIzoC62ymtn/79YQkikHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pcrgzyy8oNqEXZdE/0w7rUhxHgybqf0c2WdYe0WXvZo=;
 b=ODA+zQr+0DKq6NrGV2dA2PvSK1JdL4rILItImgoC9sKUcoKDMGBxO1BNAN720AufD0cj4ieF8eoIE88DdM80BKNg8Zcv9HPEd5Yw6QIURSajuU7xtaWWp/nQaiDx29LdHyEC7vI8dNRtlYZPYM69i6ZZ+W8kmuyB6fHKK/P8CUs=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (20.180.35.76) by
 BY5PR21MB1505.namprd21.prod.outlook.com (20.180.19.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.7; Wed, 22 Sep 2021 23:55:26 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::fca4:8ad1:90fd:bc63]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::fca4:8ad1:90fd:bc63%3]) with mapi id 15.20.4566.007; Wed, 22 Sep 2021
 23:55:27 +0000
From:   Long Li <longli@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Thread-Index: AQHXiceSNIn8c8rqq0aMs/Uc2xnVEKtlJaUAgAARXqCAAAZzgIADIFJggAC3SwCAAv3hYIBE4/Sg
Date:   Wed, 22 Sep 2021 23:55:26 +0000
Message-ID: <BY5PR21MB1506091AFED0EB62F081313ECEA29@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <e249d88b-6ca2-623f-6f6e-9547e2b36f1f@acm.org>
 <BY5PR21MB15060F1B9CDB078189B76404CEF29@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQwvL2N6JpzI+hc8@kroah.com>
 <BY5PR21MB1506A93E865A8D6972DD0AAECEF49@BY5PR21MB1506.namprd21.prod.outlook.com>
 <YQ9oTBSRyHCffC2k@kroah.com>
 <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB15065658FA902CC0BC162956CEF79@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3083f4e9-5ea4-47c9-aab1-5be6659653ec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-10T02:56:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3acb68c5-fd61-44a1-8579-08d97e247376
x-ms-traffictypediagnostic: BY5PR21MB1505:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY5PR21MB1505CDC5097C1A16C63D4D20CEA29@BY5PR21MB1505.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wTT4lvDl3tLkneVX1CLQZF82JJZE6wonuvb3U8R1pl19CcU7RU35c5SYWvSxi4wneLjK2bfjJN58Aqht+Z80FITPHTQSdIvxWKlh5IL0LSBNaulcSON1Zjwc1e1Ot4kMUXzdccWkeS2pIN+kunjCa2oxarI6oRmEhzfxZWshUBAZ+SbyBQ58s5aOWYmOZtlZDL3bOnK2V570YlF/jHgXuzEunObE/TksPX9BGuoTY1nC3VVkL2MgSI3F+vLMWNJRZkgNTeTRjTo6IKDi8Jnp9Go5o4nOtd2vzQ7/kODvcwdRndfvwNeyMCjxxnWPWbyBuhs+SChWr6JoCgGrXMniAUzzHWwtYKUAHDJCgJA6b1OvyluSN3Bis3TESHbpfEA+4uBpeZcKFUha78AYPA2IW0MYUG8LWYeNsgvnkYquzLtpfc+NTqxVLnc0DhaA+6vOKuWFc7xBXViwtYqLZV0U1/wrJBxugf9k2lyiTxocL9pitO99mqQoWRrPvRT1FKEWwb+tGLRxbk52giwnsYqpdW4HIbPsec/hotlXWO53Wr+V10KlUeD1iSsk0dpP6ztR6kfkNhs3joIWWSAc8utL6I/SGbYHrN3Gw7bJobyV2u0I+nARTAZgoSNGXiMhd19F4W+VSdYTt2s3u3s7nBP7lu+Y2YpDXE+LeVi1yCxWNMOpoZrgQekROHHzROyJP8/o9in2Zh1F1KHJqo+I56++5aIGAFhiAq0l98OIxVQj7Q9foHbDttwIH6hwZCmYRbmIO1yB6U2uCPa+sQYP317PKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47530400004)(186003)(4326008)(966005)(26005)(2906002)(508600001)(5660300002)(83380400001)(7416002)(8990500004)(66616009)(66476007)(66556008)(64756008)(55016002)(66446008)(8676002)(82950400001)(54906003)(86362001)(7696005)(110136005)(76116006)(66946007)(9686003)(122000001)(10290500003)(8936002)(38100700002)(6506007)(33656002)(71200400001)(38070700005)(316002)(99936003)(82960400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kMd2rIiqJ2A6EwHXKYPGN/5M4Zw7zaiwSw1/mBuPr1lqF3fJVrZ+uuGIdmPM?=
 =?us-ascii?Q?cAQLTmwEvDyCi07VSla3unvvq2KZPP8R6OEJRMfZZoUTzJttp3UH/KjWrurM?=
 =?us-ascii?Q?ZcaSk2iouQWL8UmhdIF6Kq9iF8ekQCWe6lfosIZrQcilvq+mUBkCsOnn6XkD?=
 =?us-ascii?Q?pifBVkYUcIpc2n423xCS1pN+F+LooLbRzfecMhW5ovNH7b0BtrFNf8d5pvZK?=
 =?us-ascii?Q?RsCdBXv/2F/nrg1Wve0k0nOOuTu3QHhatatH7rQ1iFTQD+ggvLXW6LafJMou?=
 =?us-ascii?Q?frIW+OukyZOoG6kIb8bl4Mq2a8I8IV63GxBVsv6vMvlQmChKO5MBrfq+ox2n?=
 =?us-ascii?Q?bQm+5Opw1kYm9fTX46U/cw7yOJdZ2KkENWRu6ImGMTXwpCj1xH85jrcmmTVH?=
 =?us-ascii?Q?ulQp6ctom0wSexxh/bR+F9h4G5pgxPy7qlJJGtCI+gpEGCFPAIMC8BD+RQ4x?=
 =?us-ascii?Q?XHRtBdY63ytj6f+ZbUXgSMLC2exByyFLP5NN2CreIQUXGqhLNvMrCFC+kSRX?=
 =?us-ascii?Q?sfUq5EW/3PvrYQEoGDdHeNRDswLU6xB5Vp5a5GcEo84umCIit3PDUbLuwHje?=
 =?us-ascii?Q?30VwXeRN4TEByP8vRvd2MFLWNYmcEoqNsh/FqVP8GllSmN7dt1MLxUE+oCPy?=
 =?us-ascii?Q?AlAAbcw8WsEPixS7fWeHu8jZRaTEupBEKyuhYTrc3dbB71l3D2CXE4ttySQu?=
 =?us-ascii?Q?BKlT6s9R21obzbk067V3NVkgjcidzapNuJsQDLnjIvWcRXGHXXDVDreqWXPa?=
 =?us-ascii?Q?BHNgn+Mdi9egNBY8RbWw2a+AUuMB2+sjxHQfRnbkQ3ryeqwkNVQKfMnOCJ8Q?=
 =?us-ascii?Q?fBbb0p46qMd3T/B0K6GX9PSMMGnoc06DvdBruVgMF6+KC6EbgmpWag762dMq?=
 =?us-ascii?Q?y3c6biVu2QdNyIfjBQ3m8dWd3BPVMBZz15l1+G11XFg1i1/k8mrK1fTYoiqM?=
 =?us-ascii?Q?tUjksGIn9xX5UhzQvi6BGtyUCmz+wIht8msLAOP2wptH8nNpJ7s73Z5MNV/L?=
 =?us-ascii?Q?VjCwQNNNkvBPqU3F6kksemLJENEG0jYpEm2WyB4IGyIP5lFK2A1GJTdqbIYZ?=
 =?us-ascii?Q?q9/ZZSzCHvYylviQu6ZltS7pbxXh5N60v6T/SL/fb5M3luXUvqPAmqsi0okh?=
 =?us-ascii?Q?eihUaNcfCUDzTDEuZLxaK9TkrMuUFs4JmEm3OL6jnaJvuzsv+gwVmvA0wD3n?=
 =?us-ascii?Q?sKNhTB7+IUmIEgcxxNGx+j1IggGNgElfEAvQXIdyF1OzeVsobV5yU+hvXgVC?=
 =?us-ascii?Q?IYqgaEjSo5+TPK1s+crteAI5AmKR49/CbdoMynh+u9WWZcJi1ApyllBvl98T?=
 =?us-ascii?Q?oKM=3D?=
Content-Type: multipart/mixed;
        boundary="_002_BY5PR21MB1506091AFED0EB62F081313ECEA29BY5PR21MB1506namp_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acb68c5-fd61-44a1-8579-08d97e247376
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 23:55:26.8943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjB3QvbhgaJXcZui/0glSgUFiF9Lvqw0DI99ZoIAk61Pt4CHg9jn9lnhXSRSCHBbjaaHDYz0Lwd3CbNn96zPwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1505
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--_002_BY5PR21MB1506091AFED0EB62F081313ECEA29BY5PR21MB1506namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Subject: RE: [Patch v5 0/3] Introduce a driver to support host accelerate=
d access
> to Microsoft Azure Blob for Azure VM
>=20
> > Subject: Re: [Patch v5 0/3] Introduce a driver to support host
> > accelerated access to Microsoft Azure Blob for Azure VM
> >
> > On Sat, Aug 07, 2021 at 06:29:06PM +0000, Long Li wrote:
> > > > I still think this "model" is totally broken and wrong overall.
> > > > Again, you are creating a custom "block" layer with a character
> > > > device, forcing all userspace programs to use a custom library
> > > > (where is it
> > at?) just to get their data.
> > >
> > > The Azure Blob library (with source code) is available in the
> > > following
> > languages:
> > > Java:
> > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.com%2FAzure%2Fazure-sdk-for-
> > java%2Ftree%2Fmain%2Fsdk%2Fstorage%2Faz
> > > ure-storage-
> > blob&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C778083147
> > >
> > 8ed49b16e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1
> > %7C0%7C6
> > >
> > 37639965101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > DAiLCJQIjoi
> > >
> > V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DwcNhsEoH
> > LV0VBc
> > > uDf0CVXl7W0Ug9Cj7Q92%2Bw6qizroU%3D&amp;reserved=3D0
> > > JavaScript:
> > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.com%2FAzure%2Fazure-sdk-for-
> > js%2Ftree%2Fmain%2Fsdk%2Fstorage%2Fstor
> > > age-
> > blob&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C7780831478ed49b
> > 16
> > >
> > e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C
> > 637639965
> > >
> > 101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
> > iV2luMzIi
> > >
> > LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DI%2FfhdPX3Unz6S3
> > eBPcpl
> > > %2Bh55nKoV0u%2FO0%2BYgjLy4grQ%3D&amp;reserved=3D0
> > > Python:
> > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.com%2FAzure%2Fazure-sdk-for-
> > python%2Ftree%2Fmain%2Fsdk%2Fstorage%2F
> > > azure-storage-
> > blob&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C7780831
> > >
> > 478ed49b16e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7
> > C1%7C0%7
> > >
> > C637639965101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > MDAiLCJQIj
> > >
> > oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DaAwsi%2
> > BPVsN
> > > tsDMJ7rKnRDigNc41fIao031lde247Nc0%3D&amp;reserved=3D0
> > > Go:
> > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.com%2FAzure%2Fazure-storage-blob-
> > go&amp;data=3D04%7C01%7Clongli%40mic
> > >
> > rosoft.com%7C7780831478ed49b16e6308d95a2b7ae8%7C72f988bf86f141a
> > f91ab2d
> > >
> > 7cd011db47%7C1%7C0%7C637639965101378114%7CUnknown%7CTWFpbG
> > Zsb3d8eyJWIj
> > >
> > oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10
> > 00&am
> > >
> > p;sdata=3D43JhbGsYQxA%2FoivNd7C3z7DSYO%2FPONCoaW2v7TN6xEU%3D&a
> > mp;reserve
> > > d=3D0
> > > .NET:
> > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.com%2FAzure%2Fazure-sdk-for-
> > net%2Ftree%2Fmain%2Fsdk%2Fstorage%2FAzu
> > >
> > re.Storage.Blobs&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C77808
> > 3147
> > >
> > 8ed49b16e6308d95a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1
> > %7C0%7C6
> > >
> > 37639965101378114%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> > DAiLCJQIjoi
> > >
> > V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D6ClMeURlt
> > cBv1q
> > > 7l7PGGrxXVJbVDt9uMBlwoIVh7Wpw%3D&amp;reserved=3D0
> > > PHP:
> > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.com%2FAzure%2Fazure-storage-php%2Ftree%2Fmaster%2Fazure-
> > storage-blo
> > >
> > b&amp;data=3D04%7C01%7Clongli%40microsoft.com%7C7780831478ed49b16
> > e6308d9
> > >
> > 5a2b7ae8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6376399
> > 651013781
> > >
> > 14%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> > LCJBTiI
> > >
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DDuZO539vd76c%2Byaqjn
> > hetp%2B3T
> > > i0b74601ZkNe39SNK4%3D&amp;reserved=3D0
> > > Ruby:
> > > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > > th
> > > ub.com%2Fazure%2Fazure-storage-
> > ruby%2Ftree%2Fmaster%2Fblob&amp;data=3D04
> > > %7C01%7Clongli%40microsoft.com%7C7780831478ed49b16e6308d95a2b
> > 7ae8%7C72
> > >
> > f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637639965101378114%7
> > CUnknown%
> > >
> > 7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> > LCJX
> > >
> > VCI6Mn0%3D%7C1000&amp;sdata=3D6Zviu1IuRQE2do9bDCae2iJv0W2KOJu90t
> > XSR6kDAR
> > > 4%3D&amp;reserved=3D0
> > > C++:
> > >
> > C++https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
g
> > > C++ithub.com%2FAzure%2Fazure-sdk-for-
> > cpp%2Ftree%2Fmain%2Fsdk%2Fstorage
> > > C++%23azure-storage-client-library-for-
> > c&amp;data=3D04%7C01%7Clongli%40m
> > >
> > C++icrosoft.com%7C7780831478ed49b16e6308d95a2b7ae8%7C72f988bf86
> > f141af9
> > >
> > C++1ab2d7cd011db47%7C1%7C0%7C637639965101388074%7CUnknown%
> > 7CTWFpbGZsb3
> > >
> >
> C++d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn
> > 0%3
> > >
> > C++D%7C1000&amp;sdata=3DHH6jrqREWQ%2BkoRR%2Fsb02wRXnuLU5il4Erzm
> > rBvUZu5w%
> > > C++3D&amp;reserved=3D0
> >
> > And why wasn't this linked to in the changelog here?
> >
> > In looking at the C code above, where is the interaction with this Linu=
x driver?
> > I can't seem to find it...

Greg,

I apologize for the delay. I have attached the Java transport library (a tg=
z file) in the email. The file is released for review under "The MIT Licens=
e (MIT)".

The transport library implemented functions needed for reading from a Block=
 Blob using this driver. The function for transporting I/O is Java_com_azur=
e_storage_fastpath_driver_FastpathDriver_read(), defined in "./src/fastpath=
/jni/fpjar_endpoint.cpp".

In particular, requestParams is in JSON format (REST) that is passed from a=
 Blob application using Blob API for reading from a Block Blob.

For an example of how a Blob application using the transport library, pleas=
e see Blob support for Hadoop ABFS:
https://github.com/apache/hadoop/pull/3309/commits/be7d12662e23a13e6cf10cf1=
fa5e7eb109738e7d

In ABFS, the entry point for using Blob I/O is at AbfsRestOperation execute=
Read() in hadoop-tools/hadoop-azure/src/main/java/org/apache/hadoop/fs/azur=
ebfs/services/AbfsInputStream.java, from line 553 to 564, this function eve=
ntually calls into executeFastpathRead() in hadoop-tools/hadoop-azure/src/m=
ain/java/org/apache/hadoop/fs/azurebfs/services/AbfsClient.java.

ReadRequestParameters is the data that is passed to requestParams (describe=
d above) in the transport library. In this Blob application use-case, ReadR=
equestParameters has eTag and sessionInfo (sessionToken). They are both def=
ined in this commit, and are treated as strings passed in JSON format to I/=
O issuing function Java_com_azure_storage_fastpath_driver_FastpathDriver_re=
ad() in the transport library using this driver.

Thanks,
Long

>=20
> Those are existing Blob client libraries. The new code using this driver =
is being
> tested and has not been released to github.
>=20
> I'm sorry I misunderstood your request. I'm asking the team to share the =
new
> code for review. I will send the code location for review soon.
>=20
> Thanks,
> Long

--_002_BY5PR21MB1506091AFED0EB62F081313ECEA29BY5PR21MB1506namp_
Content-Type: application/x-compressed;
	name="shared_library_for_azure_storage_fastpath_connector_for_java.tgz"
Content-Description:
 shared_library_for_azure_storage_fastpath_connector_for_java.tgz
Content-Disposition: attachment;
	filename="shared_library_for_azure_storage_fastpath_connector_for_java.tgz";
	size=41107; creation-date="Wed, 22 Sep 2021 22:58:43 GMT";
	modification-date="Wed, 22 Sep 2021 05:10:51 GMT"
Content-Transfer-Encoding: base64

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
LCbklRPjFGa/t62EVCvOOAZePZib2QMUXUhECcwenTsLgqG5QvrEPIQ9VwIGDmcScNgtZm/6SJ87
7n0BnRtsxCg6sC6aQ110K0uZZ9XBYgIWgeT6gIfc87Y4Jk3lwsRYwME9J8UCrTJ3uTO6u2e6AsxD
uzRgY04wvPyBr37EKMKLR08vvDu9OHnnrHr3s3z+xZtvvvPsyfMXF/1+ffb0/OKEn4inF987afki
v3Fy/uh/d3z8cX/6+cUXb5zI9/Hhi/6Hi5O3TrieD/7z//PHy2d4crq/c/VvP9reubwI3rj8lx9t
YQ256AvcFd7er/GvJ/+Xl7/+yefv4u744/LW1Y2++OTi2XP5iZMfnNy/+rf/emLNg6tbeTRO7l9+
8CdvnZiT7/Gty3eunoJ/+3LwF7938m/t8ifPOl7qZ8/P+sVpzecXPz764E/u84MP5MauPaG6uu8b
39R3vWnuetPe9ubzD3GXePNyzb5/tUQ/wEMffHpbr7cu3z68ztUt85/TQ41nZyf3f3R12R9f/sz2
n99/C5d/42rN8B/uwf69gzWe7rPwV9Zv/Fr9Flu//vCPbvuwlg/r7cP61g8b+bDZPmxu/bCVD9vt
w3Z68MNVWc/Rzz+z5tcBcoQziwW+jyf5B6qw8eC3R7+Cd34CmYvHP3618zdfTd96NX3r1cytVzO3
Xs3cejV769XsrVezcrWbVu5fDy/o/+ylu/VyX2/tbr3c11u8Wy/3WlZveb2rt7ze1Vte7+otr3v1
3OtdPfd6V8+93tVzr3v17OtdPft6V8++3tWzr3v1zOtdPfN6V8+83tUzr3v19OtdPf16V0+/3tXT
r3v11Kus3g3LpF5lmW5YD/Uq63HDg6uXPfhXE9C+ZBATDuZL/3onsrz61v31nz/5yUl8gA9d3YL+
9frq5Q//9tsv/Xt86bbNvBH5/5U+w7dfeslm3sjM/kqf4dsvvWQzJ+b8V/4M337p2mYeOHGuLiZW
dvX67I6nn3550c9Xi7v9+483997J979/+dIb+Lf1itedbHff3+XL/7q6In+9XuG3D44e8qvrbser
L82ew7N+8eLs6f45vIGvfufbvz/17/yLfNbb6eNH5SyffXkKcTjN//vFWT89v3h2lj/vpyOfXzzP
F19wpZ/2ilfXD/3P/Pv8w/Oz+sPt/R++uHj0+IeVe/3wi/k3mNkeQuA/OX7w8J/808qb72injbLB
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
Tbd5Le3zpkKBawoHl/waz3f4+1cC/neZYvVX/fd64z/iyZx+42X138Ycx3+c/Tb/65v5k4yqjz/4
+U/f/uzd058dJFQdvMain5MX5/3sB0+etX6y+pivfC8n5wAVJxcA2S8+/+LSRq05CC9xUZ+K5wmq
5z+t/vsrc/Ej+e8jdbK5je52ffNyl+7M1VG/X+0K4BxeXhyUt/7m1aubb/Holc1d+J8m19vJ7CW8
6f3JAXj9AweOPb75yku5/Yss1raX21aurqLTX3z285++9/F/+seP/3H/xCWW+JdPTt9/+5NP6T85
fffjD3713senn32C/+/j9/7HZ+998umVK+6mq1365l5ypw/mtJVrgvanJa98+/dn//3Z+n/9l7t/
40+v/9Za22/rv7+Jv9ez//XZkztk4Gvsvw/62/3/Jv5e3/6vX7tRCv70/bf4wLf7/038ve79v/ra
JAd/+v4757/V/9/I319q/4UWfufr7L835H/f7v9f/u+vIv97Wa7nf/tv87+/ib+/+Pl//5ef0kPI
j/17P+u3f9f/von9v1v/WxXMcf8n75dv87+/kb+/rfrP57n+DtJ1Anl7uMrbwyt5e7jJ2+r0evQE
N31xQtF8+PTRs4dsW/vTzZl2+CZ7lj78OD9tz57c9M7bZ2f5y/Ob3jnrn/c/PPxlvmDV5u0f+Hm+
qF+svyofuf3WH7azR7/vZw/fv/rvd9f//NGrfLP/ofbnXKpz+fY7l8cVr723vflKl+LdP7r48qG0
EfhZf/z86hEuO1eeXPa1vFTsW9zoKpfvIIr0yZfnF/3Jw8fPMq9C7XJf8vB/cO/k+ydHv/Dw837x
9tP22fOWL/pHn/yqn53jnt/55Wf3Hzw4DmVd/dplg6xHjx9fbuFlw+L7+26fFGbXXiazrD0tryfM
rhH0q1zFo4ju1gbzxmjc5Vd4fWz1k/zo6aOnn0/Rz69OmOZ9y/e2a//42hUenPy3bXjXm3de/jAb
5PLxT86etqt2Y5cvTF8oWJWTM4blf/3bq0/xpV/zjuZu0bjMw6f9Dxfrct5fvzJdiDf1/MXF/s68
bN9dP/BFPv/48KmO1uHqyf7t0dN2/Fh3b3R/3iEe7erk3bDZ63PiEZ9ffuL6jv/bF48eM1nuFe6S
wvH8aseurvfwrp27nld09K07t3Ra3KsvvnGi3lhv4YZFum0db128D55efPC0Pao3HJIHx2cCF+x/
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
/w9tB3nbAFoCAA==

--_002_BY5PR21MB1506091AFED0EB62F081313ECEA29BY5PR21MB1506namp_--
