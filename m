Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE65BE82E
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Sep 2019 00:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfIYWQX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Sep 2019 18:16:23 -0400
Received: from mail-eopbgr1320130.outbound.protection.outlook.com ([40.107.132.130]:6166
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728277AbfIYWQW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Sep 2019 18:16:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sot1f9Y58IdYsy7lGHFtc8ONOqwUEnnekosvr0l4xZ36XNRPlpDNHz4qG2FVJr6zBbvWlNQUNgKMMpoCbQ9br4bNt/MQmFrKxrEm8AMQEUwNffmk0q35IgSfmOhUGb4OSXpvXEtYNdd7pqWEgZvO2tyuzaAWTRyEylDvCPwmqdlXq8K7qYxXi4/f7yHDMJfDXYzqbk3XYCa8+JpT9J2A6QcIMtI6r/W4rc17MZUmHBCm4UCEbdULIBIAvFF9M1Cs7btxjR6eWJi5VCsqe2lDTLjciDp+n53sU84XTt71cB/meeaREwaN3BNl81ESSjbAZa/5bd9US2T2uSYIP8xdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM3WYywFc/OjM6ZRxGVQJDOpPB26M/wiA8GDFJk2VXU=;
 b=Sy3ZY81IM4cdJLQDAxPgh2krV4yIm4JO9fr8IJaP+wPeOc8CB2q+jqpxEpIR9K/ce0s9dZIsNZcjZSSf0g4imfvV2/9rpvbFafCJHQeI25YJXaqu0+hbsA4q2K0qPUdjORcjZ+7mcs19OnNtgZPrCR6C72xQwgzLVwlf8JC4kIyNuo66/3JQjIaNRK2wwk6GV/qefbvVjlXhVyt8Segez39EdjQ3Bno/NM+j/6UMZFCILBF0GS3ntsZB1I9VSTdtLFLnce2mg99Pl+lbMPxQmjMH8K9mgJ+j2sA5ngzl65CJlVIETcV0YWXet1idSMZpC9yNk5ajriCnlXPOjve53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM3WYywFc/OjM6ZRxGVQJDOpPB26M/wiA8GDFJk2VXU=;
 b=dHL0EUAPjye7GPKMoG8MujPyl4fCkLYwTH33bMB5Rb2f6M5XK8M51aXMCcA9uTPF6ECJeA2xTJt9KLDRcXfoxlFXUxSjl75crwfFPXyJOcxSjWkCprH8FFFAtA9C19SRBd/Diz7vPL54wvvHYSrlSLH4YsZBcHunGYxriPqTEyw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0137.APCP153.PROD.OUTLOOK.COM (10.170.188.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.3; Wed, 25 Sep 2019 22:15:18 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.004; Wed, 25 Sep 2019
 22:15:18 +0000
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
Subject: RE: [PATCH v2] scsi: storvsc: Add the support of hibernation
Thread-Topic: [PATCH v2] scsi: storvsc: Add the support of hibernation
Thread-Index: AQHVc+yzKPLAAiKv9kWlGVY81JBAn6c888eg
Date:   Wed, 25 Sep 2019 22:15:18 +0000
Message-ID: <PU1P153MB0169E8F4FF7FAB990A10954ABF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1569442244-16726-1-git-send-email-decui@microsoft.com>
 <201909260511.qkZEo9lk%lkp@intel.com>
In-Reply-To: <201909260511.qkZEo9lk%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-25T22:15:15.9530993Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c1caed55-c678-4d8d-9f8d-ec8d6f3aecd9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:35f9:636:b84a:df21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb851f3f-cf5b-4736-7622-08d74205d956
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0137:|PU1P153MB0137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0137F6898304D73C97B1E707BF870@PU1P153MB0137.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(10290500003)(478600001)(6916009)(54906003)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(55016002)(99286004)(22452003)(10090500001)(5024004)(316002)(256004)(86362001)(14444005)(9686003)(8990500004)(71200400001)(71190400001)(33656002)(5660300002)(52536014)(107886003)(6246003)(2906002)(6116002)(4326008)(14454004)(102836004)(6436002)(305945005)(53546011)(6506007)(186003)(46003)(7736002)(229853002)(25786009)(476003)(7696005)(76176011)(486006)(81166006)(81156014)(8676002)(11346002)(8936002)(74316002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0137;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MU1b1zrHJuP1rmyul436nE/3U8SnUrwIIvYG/zBMeqJ45JUpaQhfC5/7CIGspkCj26KhHamsxotZoPuhiS8GJnB69x9dFftWgD4hTk1ZqezXsdIruUvj+QqEQ212W3gXtBum+4nfNPvyDMJlhcvz0GYfjj1UfmW/BXXiFK9Xv7/VWmhwdJgjPPMGlnUtlVNUOtFpzcKm+SBvoXYkUu4qBxg52US+Tz/MRdnGVTAjbiaacXySYbjOJ2Fo0kB1QH5b+Gr3Z6ZAYiOBmGlHFBl0RpZr2igKAuzWA2ES0dcWOJ0JVdbL3AusTzWUTfL9XO070K6cSK+SC5QN1jfGLu/B4wBgDlcKRMZ4wM1Vp997j/dns8JzLW57X6OBjtVfbpjWbo/++fSB+xXHMCqjeVyqHsHQsPErVnNuwsN6eMhP9PE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb851f3f-cf5b-4736-7622-08d74205d956
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 22:15:18.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JiFNJj6MxeG2cl5UAIrFA424cvgEVzz3sQENaahJ7Z/gr9AmiKPklCm8jyx/Yzi5YUoK+jSUhQN6VI1NirdQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0137
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: kbuild test robot <lkp@intel.com>
> Sent: Wednesday, September 25, 2019 2:55 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: kbuild-all@01.org; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; sashal@kernel.org; jejb@linux.ibm.com;
> martin.petersen@oracle.com; linux-hyperv@vger.kernel.org;
> linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Michael Kelley
> <mikelley@microsoft.com>; Dexuan Cui <decui@microsoft.com>
> Subject: Re: [PATCH v2] scsi: storvsc: Add the support of hibernation
>=20
> Hi Dexuan,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on mkp-scsi/for-next]
> [cannot apply to v5.3 next-20190924]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see
> [...snipped...]
> config: x86_64-rhel (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
> >> drivers//scsi/storvsc_drv.c:1981:3: error: 'struct hv_driver' has no m=
ember
> named 'suspend'
>      .suspend =3D storvsc_suspend,
>       ^~~~~~~

This patch depends on the below patch in Linus's tree (today):
271b2224d42f ("Drivers: hv: vmbus: Implement suspend/resume for VSC drivers=
 for hibernation")
So, we don't really have an issue here.

The mkp-scsi/for-next branch needs to do a merge with Linus's master branch=
.

Thanks,
-- Dexuan
