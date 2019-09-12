Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0C5B168F
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Sep 2019 01:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfILXIM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Sep 2019 19:08:12 -0400
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:34200
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfILXIM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Sep 2019 19:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aN1MZmfCZBKM3lFuJqPM1d5Ci8DsQ1fFkFgCc4iSVAVes3miFSvJRw7d+5trg536rz3lqHnSf5rcl0M7F4A/PSjv6oTtTepkdoTZOGVAnhCz3oL/IulpEGQplUo9Hro03E/L8S8nIWyTnqpb4H4ku2KRqXw44Qoj69hKfgQ1DgmhzhWfwwvEXWK61O2WEc9yBGe7MUQoD1d60LjWJJ1xQJNcxcmUqFWKyA+MH8PBiSxUP71ee3JIYZY7ImwfzTiuBn/sWPH5Sh24NaPwbrdRxYzhSHFrQ+uOQnaPzQQgIfcoFP0DERNBgoYomLFxeegepEpiCzQYqOe/mU3JMTvvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA/lEk/3RVSHl6UnBQicUA+TqsIdI9JcZmTEyJ0prMY=;
 b=odfK1631oSZ4Y90XLYOhvYZ1L+pcdFteGSKISP6P/CGwnuNTIUJyhV/KaAkkaeLdGJxoxY3Bh03B9dJQnrg5bhyatPRqcdzGBlk87DCX1hUjAtVJuCW7NweiJCkAYSrZ0jH25aUYAYruF41A6h6+0beLtdsx6ZlihqDXnWUSVgtckxy0KHN9oYKs2YVa8R4S/t+sCzswSxhmdEgoaoPW69VnzGDJD5P7R8oJ+2pNCpSnZzmeBodEzDoxBdnZ0uyP9Tq+i9VdSTJ2+LPuWu04I8CNxuULbHReUxgWGBLd+/KYLTiVDEgwX1635FVtvDtk5UdUe4c0+/UyXCl9ZTXSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA/lEk/3RVSHl6UnBQicUA+TqsIdI9JcZmTEyJ0prMY=;
 b=BNAG8byPAPaRXQuIS61DxYdbNW2aEy2zgjmjCv7GU6SRXbC/8zs1BbfL6twrW1zUpgm3gTJ6ei3e/WaRDalWiCJ7qMlgMvPOYBP9C/2ivQc74gT0Uk+t3LTcyTus9NKgkxjuR6UT3bvcDVUqY1VFOtJ0SvIMwprUkqm3iEMHMwI=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0122.APCP153.PROD.OUTLOOK.COM (10.170.188.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.12; Thu, 12 Sep 2019 23:08:02 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3415:3493:a660:90e3%4]) with mapi id 15.20.2284.007; Thu, 12 Sep 2019
 23:08:02 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Add the support of hibernation
Thread-Topic: [PATCH] scsi: storvsc: Add the support of hibernation
Thread-Index: AQHVaazHPXY2qtgdDk+1Aqxz2LcgUacoqbnA
Date:   Thu, 12 Sep 2019 23:08:01 +0000
Message-ID: <PU1P153MB016926F6283DD85186305002BFB00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244905-66625-1-git-send-email-decui@microsoft.com>
 <201909130413.j9CHsgZl%lkp@intel.com>
In-Reply-To: <201909130413.j9CHsgZl%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-12T23:08:00.1119436Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b9261c01-9c04-42a1-8872-982055851f05;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:49e:db48:e427:c2a0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d42531e-7cba-4de7-f06e-08d737d60f9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0122;
x-ms-traffictypediagnostic: PU1P153MB0122:|PU1P153MB0122:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PU1P153MB01227B0076E3183F9C5D6B00BFB00@PU1P153MB0122.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(199004)(189003)(446003)(25786009)(102836004)(54906003)(4326008)(86362001)(6506007)(11346002)(53546011)(8990500004)(305945005)(10090500001)(7736002)(22452003)(478600001)(52536014)(6916009)(33656002)(256004)(74316002)(14454004)(14444005)(316002)(10290500003)(8936002)(966005)(71190400001)(71200400001)(186003)(76176011)(66446008)(46003)(99286004)(64756008)(76116006)(66556008)(66946007)(66476007)(7696005)(8676002)(81156014)(81166006)(6306002)(6436002)(55016002)(6246003)(9686003)(486006)(5660300002)(2906002)(476003)(6116002)(229853002)(107886003)(53936002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0122;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tMyySxxrjxxcOZalUttq21+V3szzFlSuEF9FCpnTPdrSlmhzEnqxklpDk4KlLn7q0av4HHhPSdGc3KigcTbklxG+I6jo9pKq2cd5tThkEHrxVfOGu1s9Ej4V9k7Sm1CjY4o0yc4Y/tPv6TZhiN2V8RAb5Zhc954+nUC3QiMYTHUj2rUXr8T9L1pE7gfPGxvm5hmnZIK6eDY4dBIFPhz5YaxLSwKlu6VL1Rf56nl7B5eVI+wnB7doMbqhz6h/mjqSHBekcw5qkGWaKYSl1oVqFpTUYV/FnZc81LFEOr8a7bB+dH46KsDRwArj8RQbckXc8VIfvZzZNnhMZINQMHkVv6YtvYLqXwgO3LASu6o2kcxh+r1MSoa1okJUU+4VMuOQIjFFKaGnMBJoEF5k5YQ6MJtBQdWuxICA8os1oORsJkA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d42531e-7cba-4de7-f06e-08d737d60f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 23:08:01.6829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRUIPkiQHvKMizyzFDZYOYYvSANAK8pSO0WhbM6Ki4J6KrsIcHT2vy7H9YkWLN2fx1I0ad9HWUy3oMRk2ZZGVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0122
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org>
> On Behalf Of kbuild test robot
> Sent: Thursday, September 12, 2019 1:54 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: kbuild-all@01.org; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; sashal@kernel.org; jejb@linux.ibm.com;
> martin.petersen@oracle.com; linux-hyperv@vger.kernel.org;
> linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Kelley
> <mikelley@microsoft.com>; Dexuan Cui <decui@microsoft.com>
> Subject: Re: [PATCH] scsi: storvsc: Add the support of hibernation
>=20
> Hi Dexuan,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc8 next-20190904]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system]
>=20
> >> drivers//scsi/storvsc_drv.c:1982:3: error: 'struct hv_driver' has no m=
ember
> named 'suspend'
>      .suspend =3D storvsc_suspend,
>       ^~~~~~~

This build failure is expected: In the patch mail, I mentioned this patch
has a build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Imp=
lement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

Thanks,
-- Dexuan
