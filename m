Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D651BA812
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2020 17:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgD0PgW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 27 Apr 2020 11:36:22 -0400
Received: from mail-dm6nam10on2121.outbound.protection.outlook.com ([40.107.93.121]:1274
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbgD0PgW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 27 Apr 2020 11:36:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgCPNf5mrLVsJpXjAiiImuVOr7x0vWkww6TJdnTkxYLhoKr/x8aIwOCluVt+HXgQgIMnbB59EdGMhWqzcXB11Rmne9+OQfLbhaWWqdqSfnvzsDO/ozhNQD4YcK4/78s7mS5fQp/cQxZGLsR5gTvhfjMGljQiaOxIhE8lBWmPNRF/lltwYao1N1l+wdfJHRFQnCYZpFZ5defXC7eyKG0wW/zaJRTryHVOo2ccsqbvHG/U+AeP/I/1hikf6DZIibF0QhY59lZwnGEZNbHZpdBR/qc8gs+SvSW5xn/HFJUfbLsvmcWbvgYyx2k6tgjefLIaokXe6NfmDPPtP1vmtEL3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7xHily1wD5iTXgbveCE5GtK30go23OGN1qi7FdhEaI=;
 b=T0D4xY323TVobF6yHMIIvun3ke4XUcHTNpwWqxINPD+U6BO/Hp6F6QA8as+T1RP5zLMbs+GIAl3ePb5HWzpwQv1VMErIWLZQqTrLvH/S/njBYt+QoRLJOd7ywNLkZdS1S28JPpWfy9DQtefedmHCfqqZ8CfBsqqkeWr1CgTo2zMmsazlwhAO2qsJ+Cz3xqsJGElycC1dWExzmeioOfux5+AADmzzl3+GdKvvkhHX8GP9bRRWKM1fjLbFzWIL4VKjW2q6rYgyJ8CadEvpeal0Pt91rZYc10IwXU1PEySqduCoC95XGNHX8UeOOryEEPXDr0UIsyT0N4fie/4jQI4TMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7xHily1wD5iTXgbveCE5GtK30go23OGN1qi7FdhEaI=;
 b=DUUYWWJvKHdp+yiIG+fG9+qbHeWvH4mg0CsHP0lI7fsJ3jcjHQ1igAoBXTui0mY7gYZ8Hb9YnjUkq8gXs8+pQfXVdmI1AstVnCzuhjoUWlbrZE+U6OijVM3Vk3NZPurB1wVwFQQn/RVzVVfCH52H4gkcqvVrWpsjO+QfNPECe5k=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1083.namprd21.prod.outlook.com (2603:10b6:302:a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.4; Mon, 27 Apr
 2020 15:36:19 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2958.001; Mon, 27 Apr 2020
 15:36:19 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Hu <weh@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Topic: [PATCH] PCI: pci-hyperv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state 0xC0000184.
Thread-Index: AQHWG84m7LFBk05zpkqgxdg/cn42SqiMEvJQgAB6BACAAIuS4A==
Date:   Mon, 27 Apr 2020 15:36:19 +0000
Message-ID: <MW2PR2101MB105241B940784CF73A8A9BB0D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200426132430.1756-1-weh@microsoft.com>
 <MW2PR2101MB10523247FBE97CDA56E7F5A8D7AF0@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <SG2P153MB0213FD4A0061C892B38D995ABBAF0@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0213FD4A0061C892B38D995ABBAF0@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
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
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4e7f9a4-9605-4ca3-1057-08d7eac0bb55
x-ms-traffictypediagnostic: MW2PR2101MB1083:|MW2PR2101MB1083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1083075FFDF4CFAB98701F3BD7AF0@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0386B406AA
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RNao9JW4U30Tyo0ElPbqHJk86uPQ4fj6vwLOBojgjUtScakW/holpGEmTOyl8oxYCcbQRK5n9OWwDM1Rxqk8/RSHgl740d4apVKTfigEiyE++CijQUcCrmlYpiOCmAxLUTg6h/Da4vb3G41119dXeSFaBVyf3NzgMx9Q3kwfVhFLeL2Lr0HguYMdWOWClSPLMKpr3wDc+PEcFrRBSiz2Uy7lLspMFBZxUt8/e76MvdAJP+HXykyfHwkEFeVYU0Mx5UmNSGOWqlY47jD7Ma4qNPIopWapdKzqo6DkkCT/GcnHyBbMu1+rtj/8/uACMGFgxpgIA9CNPjTeFQ4m3lyW3TIf+2jCdIggMjNxjvf+bUhMGZLj647yBZJn7D0QjLOcTmjuRSxwIalNN7LhjR2kAOl4mHV75lMZfwdGAHf96vlgnLbEy2o+DK/Tm9eEbcdV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(82960400001)(82950400001)(66446008)(64756008)(76116006)(71200400001)(8936002)(66476007)(66556008)(66946007)(2906002)(52536014)(7696005)(8676002)(478600001)(5660300002)(6506007)(26005)(86362001)(186003)(9686003)(8990500004)(6636002)(33656002)(10290500003)(110136005)(316002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8eOAu5A7jL0vR95JCdmggsOc3h/McScU14skbzeNfpQnRTvwVP5MK0vtc4CJ+orINm1iaztTyvgFu4OoSMpyEJ98uNdvqIK5OqrcX8MAUnGZbfQfW2mnOwlKJGPD8VAVtqUm76llE6HysXAnEu2oup/y1cdrJxmNC+pHs8EBAj+SJoI9rx5IZfOFTprRF60pcdDxFbA4BaD9D/5gQWdmNkYDJuTlbWoaRPyiFlSOU/ywvYU7pumg5q5fmBAXUx4ztiSlht5OipUHibtzEhKSzBYreeT9VRy7Lc5V4fJAd7YLgvD5diYS93vPPczPmrm6ecIIa3ciDjfeqjgVY1Wos97YmkaUdDkc7eTsWimdQPLOfZRx1yYsFj/I+DmxQXtllgraiKQO2pZ0M2cnfrV9Tj79aXuZa5eHvscFcdOzlVcRJn5v5J9ZfEyfzD8lMUUEbJ/uS7UGqWR4m3NG/gm/ty2Z8YKFNkYJhI52vDRpFIEm8WSKy+DmPVbzF/UT14HkC8PbYM6KCWI5pQv4Pq4bx4ZadoRnrLbV/NcXAQPdaiIBgYM2BHH5DjcH1IDbj+FGstuOPJb01FTNLKbkdCJbBQ0jM963Lc5OHMfNaEc1B0Pudd3r6rEJwaRj5+K2EIadgmE782A+7LrD4LL+EpSazmeOyr8UD0uOY4IGrjtiP2VBmmdxNqvaTwNh0xyeMDs4zX09K3Aj/QG1gVp+aIe/vrYtNgnAShaUEmG3VGbcHi/r6guOiUINJcyNdeKdDoMp8f9/zU9evMPT+dKl7TFWmrsnLEVXkK5mkkmk3A3OtmM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e7f9a4-9605-4ca3-1057-08d7eac0bb55
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 15:36:19.2499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvXo7aN3z4MSqIj+cMAAxZNzYbifaKddHGC7ZSiSEHoFj+5PLXz9co26a4vFf7WUrX+WWyFwVz1MldGhUl9L5gCg2MckWuP0ZK4p/RuUooE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Wei Hu <weh@microsoft.com> Sent: Monday, April 27, 2020 12:06 AM
> > -----Original Message-----
> > From: Michael Kelley <mikelley@microsoft.com>
> > > @@ -3136,7 +3166,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> > >
> > >  	ret =3D hv_pci_allocate_bridge_windows(hbus);
> > >  	if (ret)
> > > -		goto free_irq_domain;
> > > +		goto exit_d0;
> > >
> > >  	ret =3D hv_send_resources_allocated(hdev);
> > >  	if (ret)
> >
> > The above is good.  But there's another error case that isn't handled
> > correctly.  If create_root_hv_pci_bus() fails, hv_send_resources_releas=
ed()
> > should be called.
> >
> > Fixing these two error cases should probably go in a separate patch:  O=
ne
> > patch for the retry problem in kdump, and a separate patch for these er=
ror
> > cases.
>=20
> [Wei Hu]
> hv_send_resources_released() is called in the added hv_pci_bus_exit().
> If hv_send_resources_allocated() fails, is it correct to call hv_send_res=
ources_released()?
> Allocation can fail in the middle. So I am not sure if calling hv_send_re=
sources_released()
> won't cause any side effect.
>=20

Ah yes, you are right.  But that brings up a separate problem.
If hv_pci_allocate_bridge_windows() or hv_send_resources_allocated() fails,=
 then the
error path will call hv_pci_bus_exit(), which will call hv_send_resources_r=
eleased(),
even if hv_send_resources_allocated() was never called or didn't fully succ=
eed.  As you
noted, hv_send_resources_allocated() does multiple steps, some of which mig=
ht have
succeeded, and some of which didn't.  The mismatch might cause problems.  T=
hat means
fixing this error handling is going to be a bit more complex.  Each operati=
on needs
to be individually undone, and only if it previously succeeded.   Could you=
 follow up
with the Hyper-V people to see if there's a problem with doing the RESOURCE=
S_RELEASED
message on a slot where RESOURCES_ASSIGNED was not done or wasn't successfu=
l?
If doing a spurious RESOURCES_RELEASED is harmless, that will make the erro=
r cleanup
easier.

Michael
