Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEBF1FFB22
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgFRSen (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 14:34:43 -0400
Received: from mail-eopbgr700114.outbound.protection.outlook.com ([40.107.70.114]:32867
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729862AbgFRSen (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 14:34:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAtyMDNbyn3o1kbTrsj+fmqE5reoUuGiad3lFxu6dFxPjSwOVTHEDXXsVzI8g8BxygZTxFzKAZb9UBe3g+jJnxehVeK1aBXZkGItGTf4bx5iDH/WUzDj8jJD7c5d0SkoFKObjxcGCNIFIk7wm35lHhfD1DFTuyczNXZAEE4bVTfsFRJuJnoxzJNidJ/QVfxGH1QRZ3/5k21STZM8E7JgqeuwGWjZWg9XOs2oKljoa4JMyeOdah8e7/u5XPGQDh3K5DlZc3Jtk55vA9nTRfH8hy6gVH74eZ7ArEMk8RHkWU/V5qxL5Qx/UEHCvvhX9ptPxBr1MfYRXkSq3iOgXhKr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXY6unyZ5Lrdq0R5VPHdAApisAxvHSt8Dnfv32veTpA=;
 b=mHtYboBSkIvZDZRCUvAMFhR6koDjkURU3dbBJWpkMmWi74IdRqsZDOMk42aEsRK3fyutgh0h05dvkOVs86kr4X2cOKUarOuzWIgqO6Z553neveadKsxRm6tKhV8PlBMENcJJJFuk9cWcZasWo3L7+gUEKpkpbN3aJ0TNotq4yNA0iih5uS4ON5XjOd87zfrmYaEepfi3yATzvh4a5kuzjOiQ9jTPpywFF1fzNfBKxOM2JcnB08c9zida4k+iA5Rhl+DPHFEcTMpaXE2lXwBcRKp9tUC7kExv2pISPFKWXDsk2CCECWtwwO+CHXM+LmrpL9Gkwj3rydP2K8lRexHTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXY6unyZ5Lrdq0R5VPHdAApisAxvHSt8Dnfv32veTpA=;
 b=d5HU7W+DqBjq614z70Ldq5j8ttgvXhxR1lUoRk/+pyh7qu12AMt9yFs6mlRH+RMu5+VchFPGunFkOFr7JT4IJo9Sfnb3xZ+jNr1QV4A/M0j7Nqg+qLUoEnhdH0wgQl1ipL8o67nAKtS2d+J3rrhMpl1U7QhYJm980QgCP3Q7Ceg=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR21MB1781.namprd21.prod.outlook.com (2603:10b6:4:9e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.9; Thu, 18 Jun
 2020 18:34:40 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923%7]) with mapi id 15.20.3131.008; Thu, 18 Jun 2020
 18:34:40 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/8] scsi: storvsc: Introduce the per-storvsc_device
 spinlock
Thread-Topic: [PATCH 7/8] scsi: storvsc: Introduce the per-storvsc_device
 spinlock
Thread-Index: AQHWRMcT5Kf96D8yYU2GkK3j3mraO6jetCLg
Date:   Thu, 18 Jun 2020 18:34:40 +0000
Message-ID: <DM5PR2101MB1047555F4EBA64EF29F751EBD79B0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-8-parri.andrea@gmail.com>
In-Reply-To: <20200617164642.37393-8-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-18T18:34:38Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1e60c0a3-c919-4a0e-af60-fe6c3aaa252e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5bfb796-fd25-4391-d8cd-08d813b6435b
x-ms-traffictypediagnostic: DM5PR21MB1781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB1781A74DFE4DB073F5A74809D79B0@DM5PR21MB1781.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W+Lnpwu+VUZChl9Fs0O39LTCjAoUFP8CRfZ35PUIGze1QQsCBJiqCPvTMVIzJ1gMtqsPm6uIptqoDqsCCN9SGKhO+WnOJw6PoY3LZ+ez1XcaHq+YPp0K+SJ5PQs71J6j6RiylIFgWlGI2lgJK9dNB2clx6OdFIwg9i6ZiBU0nIexTSgN5RtpseUR8+Gizo3N+l4xpq81qhXuJoE6EfIOGoetJAEFU3ctFuTAHdiTCHsOAjfRq0i4uVrIQEwsSBq8cHc5vcWsGwDK2MJIZ5vmw6Il/SpLEJGwgkLGZ8Eqwbnu7x/jn/oc8zaX5y7Q/MJgB+kB62rRMZmF4tMKyA6Mwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(5660300002)(26005)(6506007)(52536014)(86362001)(10290500003)(8936002)(4744005)(316002)(7696005)(186003)(110136005)(54906003)(2906002)(33656002)(8990500004)(4326008)(478600001)(71200400001)(82960400001)(64756008)(82950400001)(66476007)(9686003)(8676002)(66946007)(66556008)(66446008)(55016002)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: T8HQZk816OtaKRnyKVidBdWmURd/WY1PC2HbME+HHPo+FLFGl5RCmfdeX6r/OEO/bs9/jvNqssxTRlyiSzso5Dvyf7YM9OtCCSBpkFPFZ5fcDIUrCk4xGcOj5H91tOmqR+wBfwFUlbXl6LPiTSDe0sdUjTtJVfQSQfsq62Wnwzw+DUUojXCvFt18dWz3GeQlRc+EFeAmDJU11+ys2jgQnjRmXlh51t/R5HNNg47SLHKvY7oYwG64IxdHCWOpC3GRFHt80dCZkgCcVxUIBb7VMi3hBX1DYzmeZfPIu6Nk0C7nEakXplzQQb16ktosv2Ol0lZW7f/bdek5x9war0nuY0UPXvQ9E0snyu8XUEOvcBM/pI1sUKZzzeqIFswogAPvXCAGtvy6AbBBjYWAcFIx16dHZlimy7BwTgjtALLYw6WYIVKPz7n1u4T/QzVIrF36PttNaeqEC47Fpeh3x65O21W3XTTlsh98VUEvvQ9T7iKt3S/kSOEUg9/3xVKgJ2Ed
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2101MB1047.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bfb796-fd25-4391-d8cd-08d813b6435b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 18:34:40.7594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I0rzYWyRcRL5CFMhCQ4HEM6iLlSqKlrKWsovczXSfogReybk0z9CkQ3UQHsB7EBvZm3ajySgAffIGZ/VccYDaxyier0BF22lwqkfmQffrFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1781
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, Ju=
ne 17, 2020 9:47 AM
>=20
> storvsc uses the spinlock of the hv_device's primary channel to
> serialize modifications of stor_chns[] performed by storvsc_do_io()
> and storvsc_change_target_cpu(), when it could/should use a (per-)
> storvsc_device spinlock: this change untangles the synchronization
> mechanism for the (storvsc-specific) stor_chns[] array from the
> "generic" VMBus code and data structures, clarifying the scope of
> this synchronization mechanism.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/scsi/storvsc_drv.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20

FWIW, this patch will need to get routed to the SCSI maintainers and go thr=
ough
the SCSI tree.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>


