Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384261B981C
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2020 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgD0HF7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Apr 2020 03:05:59 -0400
Received: from mail-eopbgr1300139.outbound.protection.outlook.com ([40.107.130.139]:30240
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726429AbgD0HF7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Apr 2020 03:05:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0SXc8afLsuwNbLH7aRrmwxtsuFtOotvEsi8zcWQYjWdxURRPCrw06miX/4uzRkDrIYKExJSrFIlTZtklc0mEiXUGlfyU+LMbIcg8wGQrZnHewevRXpgnCqMGLjroAgOHfd4kj9IZzhlhXN8ppCWHNww89iukcR8upuXZh7IjKIgsSMHZLmfx3zcKxdQeLWuwyYwRU8IlL1oR7TuCXn5T3S6orXwMIAS7gqEHyMpPtLEBwDijyQ3EhzxBCjeOs75G0HK0K4iy4+4I/9EwO14m2o2rzsnGs8u1HMOvxbvY8QJw+/hz2HxxNasdlD5UyRjEtGHv6Y7gWpZtu9gxqOC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3YeM2fac2O3aCvSG9iC9/Gm+at8Fsm08QfkYquvsMA=;
 b=V3tBVvoxC6UUWWqpmHEGlfXcWcH9wnssUT8Gxj1E4Ytn90ujLavHkLaN0cTqLOFFm4DOb5AiwfZC2fQMhNh5VG6rFMF7t4JCan/ZpCc3pkdaWbmzfvDNccSwBfzLY2fBjqgS6DYe+2Yt+fE+Mhk2HboA1hfY+Rq6nnaCcxBlu1RFq31zwQB9iCCaQW03DSuCFer39nrabR8D2apC8N3PZ1mYVlM+kYQdC4LgTHDLMiZ7BXFc1Z/2MTQ6WpAw3SZP+RsDwVQGzYiZmRvUn/N+715PxxQf/z2mjfvwcM6FJkOeOb1QBVbpdzJ7Mntu9VEOP2Ur2OxDEgv5+r9dPvT48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3YeM2fac2O3aCvSG9iC9/Gm+at8Fsm08QfkYquvsMA=;
 b=AE1NiOcMRA0R82mhrDgL59Kc6NFzQdgtjprDk0AylBDbqTmt76UryWioAp3/Wv8TXH7Wy5/CLO5hCoTFDyghBRnAYtdh9M6iMHw+DpaWI7ZiWup8AE5AARsc4UaF5vQNjUk24ejV+iVFQgfpUYLLbwLLdy1MlO0OXrnjno9qKoE=
Received: from SG2P153MB0213.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::10) by
 SG2P153MB0207.APCP153.PROD.OUTLOOK.COM (2603:1096:3:29::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.3; Mon, 27 Apr 2020 07:05:52 +0000
Received: from SG2P153MB0213.APCP153.PROD.OUTLOOK.COM
 ([fe80::48c2:d836:48b2:689a]) by SG2P153MB0213.APCP153.PROD.OUTLOOK.COM
 ([fe80::48c2:d836:48b2:689a%6]) with mapi id 15.20.2979.005; Mon, 27 Apr 2020
 07:05:52 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Topic: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Index: AQHWG84ovaN1uUvkhEyVQA4OZviFu6iMGmYAgABt3HA=
Date:   Mon, 27 Apr 2020 07:05:52 +0000
Message-ID: <SG2P153MB0213FD4A0061C892B38D995ABBAF0@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
References: <20200426132430.1756-1-weh@microsoft.com>
 <MW2PR2101MB10523247FBE97CDA56E7F5A8D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10523247FBE97CDA56E7F5A8D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-27T00:15:48.8414318Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3bb357e5-0b89-436f-ac44-3d0a980ed24f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=weh@microsoft.com; 
x-originating-ip: [167.220.255.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cec971fe-ab42-4f8e-543b-08d7ea796c73
x-ms-traffictypediagnostic: SG2P153MB0207:|SG2P153MB0207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2P153MB020717BBB41BC1E1CC8C63DCBBAF0@SG2P153MB0207.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0386B406AA
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XO7pX5HCGuv5Q1hU/Jo+6y3ctMnqqtExoRhpuhQYD4AjAwq0VFMvf6FjwLjpM1r4hmmzCrddZoRXqSv3Cho0XWAeHz2IMIPfOeWoWuWGluIbStu+8zKq+b/7wLj/DQ/aB+U4nTi6KJIn6tBMNAgDvI2fv2ToctGkT8rS39nRXl2NvLtMPNW10MTGninyLyERNyEBvxtGvVf8Aq0a0HvAH+B3dKARZ/Gv4bTnmLBZkGmv2Xv9P2tpDVHRilZErwALW9HvBfAKUtHjGHkxGCYX48pP6eCeG7ukCBiKUilFtbzbLorS2zKEbApYq0lIFYhnZywMEzMGvUmq5O9HUki7a/6ZK3GTxphq/kEOEICwmKYSj6lirSunb1byIjjqOlt2aaR9BpMKxSFMcxzXQSUwFPsZk2YMS7K3zHceZQV2GgEBoctA5+3VWdppD+sm8dIT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0213.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8676002)(9686003)(5660300002)(86362001)(316002)(55016002)(82960400001)(82950400001)(71200400001)(8990500004)(6636002)(8936002)(110136005)(52536014)(478600001)(2906002)(33656002)(6506007)(7696005)(186003)(66946007)(10290500003)(66446008)(64756008)(66556008)(66476007)(26005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: J9H2t7iP95mn11zOKT6vQm2oI1XFH/OTXohrzlouVzxepZEd8F/nNKXCA5TgHQc0HQWuwdDJpVwaOTzS/NSyhelSXT8Y5PO6hernLiofwkyvbU7ycUhG3jE4IkmRCDRGHOXfH+u1E88CQ9ngGniqTkbJDfu7CJGdnAPR0yALLixDH6/icUnuTv/zTWlmR3lRaGzclsZXGZmh6M0VlvmrO6bkMo4aaueXjkGnBWxJ7wPfb1u7mMNpA/R3ejXRCGZIch5qZH+pOcQo8RiTfRc/LUPluRId4pFFMgWXP768u7lLBb01lEQRn/4LWOyBFYB4bk4d9714J0lRLsyId3MpEwXTjGiRO11XowkZTHkVtSeemZz4LHM6TY0RmrWk0EbipBATiHRI/OaKdCPaQeh5grBO9iR3gJ88VKbHeXQrmbn4aMTjADaZ6LgYsiC7QEVuJAgde8WYeXrm5mgwoReqOmkLvnxYUDy2M5lAz0tb2j7+cvVZ+JhVzzTB1tdJDIeWW4kdHlazaGrMpnPghFrqqLNeKPMW7K8N5ki9F8V+WbFlxIAHNDKFFLg8n46UjFbcaECiAE3Ie8UeueVzC08UCQnu/BZLytZkD7ebvzON3XxxCbaBTFgdHrkKmeCPZwK4XUN8sn7dEr49UWQ5/fm0AV2hjoTmX3MxW28AO0Uec4ik7uC7wJI6+4SokCpQl342K/dPZCdSD/qAv36aRxqIVqw+Mw4JEXZOjQ8/aRtyCZQFjGUK0kX94jw9mPXWlc/6cvGA1nOxnh0D+UPTJiuxm3EUsrWcMywAl8Yp1AAZYsk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec971fe-ab42-4f8e-543b-08d7ea796c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 07:05:52.3396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: simh0BrEON+nSlx0jONozW0hftIzzlic8fMICo6dYuc/ny4RZ3UOxjEqgt8U0J1rubMZuxA3K5hlbi/g1sMz0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0207
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> > @@ -3136,7 +3166,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >
> >  	ret =3D hv_pci_allocate_bridge_windows(hbus);
> >  	if (ret)
> > -		goto free_irq_domain;
> > +		goto exit_d0;
> >
> >  	ret =3D hv_send_resources_allocated(hdev);
> >  	if (ret)
>=20
> The above is good.  But there's another error case that isn't handled
> correctly.  If create_root_hv_pci_bus() fails, hv_send_resources_released=
()
> should be called.
>=20
> Fixing these two error cases should probably go in a separate patch:  One
> patch for the retry problem in kdump, and a separate patch for these erro=
r
> cases.

[Wei Hu]=20
hv_send_resources_released() is called in the added hv_pci_bus_exit().=20
If hv_send_resources_allocated() fails, is it correct to call hv_send_resou=
rces_released()?
Allocation can fail in the middle. So I am not sure if calling hv_send_reso=
urces_released()
won't cause any side effect.

Agree it should to into a separate patch.

Wei

>=20
> Michael
>=20
>=20
> > @@ -3154,6 +3184,8 @@ static int hv_pci_probe(struct hv_device *hdev,
> >
> >  free_windows:
> >  	hv_pci_free_bridge_windows(hbus);
> > +exit_d0:
> > +	(void) hv_pci_bus_exit(hdev, true);
> >  free_irq_domain:
> >  	irq_domain_remove(hbus->irq_domain);
> >  free_fwnode:
> > --
> > 2.20.1

