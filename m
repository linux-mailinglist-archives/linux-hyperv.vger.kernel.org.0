Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9A22EBC3
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jul 2020 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgG0MKt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Jul 2020 08:10:49 -0400
Received: from mail-eopbgr1300095.outbound.protection.outlook.com ([40.107.130.95]:5920
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727855AbgG0MKt (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Jul 2020 08:10:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUY4JDCwYUzpsXNzdu4CyIFWvX4zsw5jDQqRuPVs8YnBCl7fxgj0zMDZrDUof08PKAp0yEzJHb9KIojn6KoMhN748zEfxRL+OSc/lkSs8ne8Mtd/CBNkSCioIohVSgva21fNis5qojIjXPXChsrR49Eb4JnUSK6Y0DVZhRE3g/rsU4yLYQvRHFBaF2rSAd4ZqpQoPE0nrGLsOOv04oiUrLVSu001rfqX9xc1KU5Y4ei1KFuZE1WPxJ6hoU1fMH5UVq7Fj98mklFuADNur1kN48crHtmYYhCQdxQ+9Az25nOUB+rMvYsaVhekUCpDWuztCArus+1lmGuYMDHiphpLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjndx/x5+JZJ+l8SatpZtKMbDb+umqL7zrzsmWiuU+0=;
 b=mcgSpznUlIaE2rJifua40QMx7vdumtJEVKOlm5VC5fIKrpbNRDBFHTSeMIQGxVO1Cu+cIJhWrWgLgGiof6qBi1cYtwZK7eryEuQ9jJPvo1zJNBNMzTnqHNZEJpgqAj3gq5LCotQQHEsEEHcBtR3FwM7k/V7hylxLFfQYARYevT1g6gS45ZcvWyOL6YTJJARI5N8KL9cQYCc61wAwL/sv6wybuzdJQwdccmwVVKlATYaZzDyczzHEESQ91zCPGTZxvGStYZge9CcDhLuv3qoDOY+Z11SMtVT6xiaD5fj/+QU8Wegh9v7uDRl+XylRDoYaVpgY/yj3lavWvqnPzhDyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjndx/x5+JZJ+l8SatpZtKMbDb+umqL7zrzsmWiuU+0=;
 b=HZ2C91DOjEeBETpoH7PsvwtjDMOGnGb3xEt566BI5mEBiMZfUSo0VdoDoizRfndL51wW9uEg6JugpPLf6NX3xLWS8y9zBqgWVJ+LvTM+qZ9fykeL8wpxzLg3gcz+Xyt7zFcvcbiuYvCZQxk3OvyGLTTX4KD7r2No6sJATKyF8lw=
Received: from SG2P153MB0377.APCP153.PROD.OUTLOOK.COM (2603:1096:0:1::15) by
 SG2P153MB0379.APCP153.PROD.OUTLOOK.COM (2603:1096:0:7::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.3; Mon, 27 Jul 2020 12:10:42 +0000
Received: from SG2P153MB0377.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5e5:3111:30f0:8e01]) by SG2P153MB0377.APCP153.PROD.OUTLOOK.COM
 ([fe80::b5e5:3111:30f0:8e01%3]) with mapi id 15.20.3239.015; Mon, 27 Jul 2020
 12:10:42 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v4] PCI: hv: Fix a timing issue which causes kdump to fail
 occasionally
Thread-Topic: [PATCH v4] PCI: hv: Fix a timing issue which causes kdump to
 fail occasionally
Thread-Index: AQHWY+YSLxC8RPb4v0CKay4JYMaVmKkbR54AgAAKXVA=
Date:   Mon, 27 Jul 2020 12:10:40 +0000
Message-ID: <SG2P153MB0377B86BE7882BC25857A64DBB720@SG2P153MB0377.APCP153.PROD.OUTLOOK.COM>
References: <20200727071731.18516-1-weh@microsoft.com>
 <20200727111852.GA14239@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200727111852.GA14239@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-27T12:10:39Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=64a9e2b9-7243-4b59-be2b-f10ce4eceacd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [116.233.42.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c7eaae1-e706-46dc-d163-08d8322615a3
x-ms-traffictypediagnostic: SG2P153MB0379:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2P153MB0379A8A9F98345D3801EB8BCBB720@SG2P153MB0379.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TsFZpw3fD2xMKWhpwpNY4d1wY9AlRiav5JOkox7b1PSnH3+NqoTPEiFRIdu2z1OBFAEc/RUQ0IBG1BQMPMnmPshGEl7QZplLQtDkDiKzuKOlsLyOlsUgEO1MjcFCHrP1za/LSWTy20o/ZaCUizVmI/Ys14aHghiZicpDLulPWiEmh57Zy6gUfNgtT0Tvaef3MJOmk1QY0nXMkjifPPzrzDpPLmZZIZN2LBAwT8tpKyXg69BOXJot6Lysr+7CEAOaDeQiWc+dyO8UYXdU3hGQVskdibpRiZ3Cjo2wakrYSxaBPCGL0MFP3XE+/eObwFYMgWHa2Ttg1ZNCcbAs86G7Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0377.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(316002)(478600001)(55016002)(54906003)(8990500004)(4326008)(107886003)(5660300002)(9686003)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(33656002)(53546011)(26005)(186003)(6916009)(7696005)(2906002)(71200400001)(8936002)(82950400001)(83380400001)(8676002)(52536014)(86362001)(6506007)(82960400001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gN71LCJEROmVye2U4ijHckOCMs+jmCfyYr9Y5bxuGkkfpwHeoN2xx1ayACGzyjuM2CoqNfCrM3U9pA7o86tfa/w0Ml+M9BC2q6YV1k412YdagkT47fgXunYeRqUcw7HIaL0nru+b8wVZM3x2thMHv7J4t+GvRwdEkZcP4Qz29aZP8FItkVKQ3beQPgswkrIKXonwobsC6gS7ymYOyE6EesyYSbPN1V+kSlrXCdM6BkEqoPd+/bkEEeu1BFoTiNxK27O/HiLFGyAmFXIQ1MxXJq3hrUnu6DWiD7dtYEnb7+JD+hsw9keNx3272LRG319TGoPtdpONQVAeZB8OZc5j2Rs0yPd7X7inFxGvzEzaUXl+cmvd/gSoKh09o+9GxkzTRZFP2xbWvFM2X+5rmKsXmfOixgIg4lYr8vDzEvuzFk5vLZc1X4pV1+aia3IyN1zHRwWyYYHTJK5wIFXzSYfzi2EUQjOGGCCYvCZ2R5/okcTEuQSPiCVocQLOFpzFrmKdj5pj5ELpoivI7d0SKsmS9Ywdik+6YhRk+ZSxaxGVrVNbBnHKiYJaEIskeqJa3+mI6wLG335JRb6CNQtI4BAdBve8hEh1AhN9a2SU4+K9/zYVnYrGl/pdSl30c8mjrOeDY/rxT66FKhRGoj7eyIfIqw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2P153MB0377.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7eaae1-e706-46dc-d163-08d8322615a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 12:10:40.9999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKxpgekG98P5zT6QSSnM4ZugRWO0yx3TyVZWqQyIY/pJqxhbcbzDUGcNe9woku9aRyALOrW2xaJIxni711hWBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0379
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday, July 27, 2020 7:19 PM
> To: Wei Hu <weh@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> wei.liu@kernel.org; robh@kernel.org; bhelgaas@google.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Dexuan Cui <decui@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>
> Subject: Re: [PATCH v4] PCI: hv: Fix a timing issue which causes kdump to=
 fail
> occasionally
>=20
> On Mon, Jul 27, 2020 at 03:17:31PM +0800, Wei Hu wrote:
> > Kdump could fail sometime on Hyper-V guest over Accelerated Network
> > interface. This is because the retry in hv_pci_enter_d0() releases
> > child device strurctures in hv_pci_bus_exit(). Although there is a
> > second asynchronous device relations message sending from the host, if
> > this message arrives guest after hv_send_resource_allocated() is
> > called, the retry would fail.
> >
> > Fix the problem by moving retry to hv_pci_probe() and starting retry
> > from hv_pci_query_relations() call.  This will cause a device
> > relations message to arrive guest synchronously.  The guest would be
> > able to rebuild the child device structures before calling
> > hv_send_resource_allocated().
> >
> > This problem only happens on Accelerated Network or SRIOV devices as
> > only such devices currently are attached under vmbus PCI bridge.
> >
> > Fixes: c81992e7f4aa ("PCI: hv: Retry PCI bus D0 entry on invalid
> > device state")
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >     v2: Adding Fixes tag according to Michael Kelley's review comment.
> >     v3: Fix couple typos and reword commit message to make it clearer.
> >     Thanks the comments from Bjorn Helgaas.
> >     v4: Adding more  problem descritpions in the commit message
> >     and code upon request from Lorenze Pieralisi.
> >
> >  drivers/pci/controller/pci-hyperv.c | 71
> > +++++++++++++++--------------
> >  1 file changed, 37 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
>=20
> I edited commit log and a comment in the code to fix a typo and pushed ou=
t to
> pci/hv.
>=20
> Thanks,
> Lorenzo
>=20
Thanks Lorenzo. Appreciate your helps!

Wei
