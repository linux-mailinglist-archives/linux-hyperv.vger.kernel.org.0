Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCFFFCD1
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Nov 2019 02:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfKRBYK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 17 Nov 2019 20:24:10 -0500
Received: from mail-eopbgr750115.outbound.protection.outlook.com ([40.107.75.115]:64481
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbfKRBYK (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 17 Nov 2019 20:24:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+zFHLuMQByd97xLq0AEUOw1Z+yxtliO0zlxXB+cnT8EO21eCPitaRlzpysRXOTBr6zIMvz3HQSsb6y7vKz8Cx9hoCZ1axW1BdWFO4bggEevmSw3USQ7VxKwWMqzzRYe8WpjbuqfmzCMG76QBol02/h85FPb5q6bZTVJq79I6Pl2+OpAeQYSzwf+yDju7IBjhLOdrSrNKS0PovIFJrgCCliHJ9zg6xK83atKI1WCAZa3dzjsdfj/BrxT/v2zuzFTaQsRpQYal7xF0Eze2MPcF4uZEclw7l6eKVuXF4bPYloccFvpvSu37IqbkyWIdLhP1YSwk6YfurGXn2SNHeQr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19bP9yZ9te5ajfi90OhIB6d3HFWLsK6fAGZ32t0JNBs=;
 b=Sln0tLX+jcEs14w7Kg9SzXIR2Mg5oxRkvjtpSWIVQ/Djqw5tJz3oHCyf5uATQjrTBuwvBaUThmhs2k88ErDOntw/pyuNicxj+xwZVjPbPeGFOpZnW6sY68BK+H535LPX/bqvtVk6oUTKq3atBbqBAVdUlgfV3sAw82qdz5BGYPkLB+apUXp4iJrH77Kow4m4KKlrXlRW4XqtZCAUaWQ/6Z5zttw4etffH0q8/VZyho+QVlKudgzcPmvcLOzhfaO9aW22TeWOdjZTlIPb4/s3wU7/iNVpeRsuLCLExtDTk/Rwb6pP0R42mWhPP+mT+S7wDkJCC0GqHSvtr62NDx0AYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19bP9yZ9te5ajfi90OhIB6d3HFWLsK6fAGZ32t0JNBs=;
 b=btrERMu/DxEHYHy0l7LXe+B0rlO2gEQyHajizcZIVJ9sflrbxgojHfpyTOojfXwg3p1v2v1qMLJOMF88DJIvbiHw1gJrW099f7y21y/RfFPPZaug3CTAcQAkfewsYg7EoQplIglOR80Rd4/iQm1Syz0XrU7+yoF2bnTY/mYs/xM=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0742.namprd21.prod.outlook.com (10.173.189.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.7; Mon, 18 Nov 2019 01:23:15 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%5]) with mapi id 15.20.2495.004; Mon, 18 Nov 2019
 01:23:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "Ganapatrao.Kulkarni@cavium.com" <Ganapatrao.Kulkarni@cavium.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "josephl@nvidia.com" <josephl@nvidia.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Topic: [PATCH v2 1/1] x86/hyperv: Initialize clockevents earlier in CPU
 onlining
Thread-Index: AQHVmb9TAIfD7Ra2tkqgwSg/PXh9y6eLwmaQgARlu/A=
Date:   Mon, 18 Nov 2019 01:23:15 +0000
Message-ID: <CY4PR21MB062904EB8E4B90192E893750D74D0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1573607467-9456-1-git-send-email-mikelley@microsoft.com>
 <PU1P153MB0169807BF9CE60FC3CA51B31BF700@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169807BF9CE60FC3CA51B31BF700@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-15T06:48:42.1892075Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=190e6afc-81e3-4faf-aab4-b7e2d8190add;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4d9dbeb-2bc0-4d0a-b8d0-08d76bc5e2e7
x-ms-traffictypediagnostic: CY4PR21MB0742:|CY4PR21MB0742:|CY4PR21MB0742:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0742AB1E7F485E1641FADDCBD74D0@CY4PR21MB0742.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(136003)(366004)(346002)(51914003)(189003)(199004)(31014005)(86362001)(1511001)(2906002)(2201001)(305945005)(486006)(26005)(102836004)(7736002)(186003)(6506007)(11346002)(3846002)(6116002)(66066001)(446003)(476003)(76176011)(7696005)(74316002)(7416002)(14444005)(71190400001)(71200400001)(229853002)(6436002)(9686003)(256004)(55016002)(10090500001)(8990500004)(33656002)(52536014)(316002)(2501003)(10290500003)(478600001)(66476007)(66446008)(64756008)(66556008)(66946007)(14454004)(81166006)(25786009)(76116006)(81156014)(6246003)(22452003)(8676002)(5660300002)(99286004)(110136005)(8936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0742;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QbqfDrtmQ3I5+tJMGVMCYjFoiapROQEdVtjxYLSWA5hNunSF4dgf0ubvVdnRyRI6U+apUyjxdJQm9kFgE8BcCidb+FYxiMdpTtKhBz6OFdAQk+cV8JKAzW4ICQyIS9Pa44LB/59RBe91ToTMerONlj58sHlFCJTZP41Xq2P/TeJO+nNow2d1P1EqIaZfal2YkAOnY5Y3TyhZzBqEmNDPRImm+v7nWwTmH4HpS8oIbHRhI1Hg0JbUcJGYDmAIA68JXXQ9kJ+5rZNswpVtI1C3QSUQLHnig262t5xHvYiOXIEHB/01ZuYpxWg1lwO8iJed62bcduODuB8R09Yv9+vCi2Bk2MuOyVpZV4js/B0dr8fYYY6bHdwPl4mXQrgSX06UEHv8iUpFGmitwvcqNE6HO3Cn0S82kHoZnKqzUkCC8ZUkktcvnVIl5+oUbVcYz93+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d9dbeb-2bc0-4d0a-b8d0-08d76bc5e2e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 01:23:15.4751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3uEdgvcvlCfYujrJOdiRmyozs1EUK6dcAe6pbe7qPtOYqYD26jgOBlZfrjgINDBYdvkvqJiXrRNEKYoJO698oHH/P/y0l1SnxWySgz6CLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0742
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Thursday, November 14, 2019 1=
0:49 PM
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Tuesday, November 12, 2019 5:12 PM
> > ...
> > @@ -190,14 +278,20 @@ void hv_stimer_free(void)
> >  void hv_stimer_global_cleanup(void)
> >  {
> >  	int	cpu;
> >  ...
> > +	/*
> > +	 * hv_stime_legacy_cleanup() will stop the stimer if Direct
> > +	 * Mode is not enabled, and fallback to the LAPIC timer.
> > +	 */
> > +	for_each_present_cpu(cpu) {
> > +		hv_stimer_legacy_cleanup(cpu);
> >  	}
> > +
> > +	/*
> > +	 * If Direct Mode is enabled, the cpuhp teardown callback
> > +	 * (hv_stimer_cleanup) will be run on all CPUs to stop the
> > +	 * stimers.
> > +	 */
> >  	hv_stimer_free();
> >  }
>=20
> In the case of direct_mode_enabled =3D=3D true: When hv_vmbus unloads,
> vmbus_exit() -> hv_stimer_global_cleanup() -> hv_stimer_free() ->
> cpuhp_remove_state() disables the direct mode timers.
>=20
> This does not look symmetric since hv_stimer_alloc() is called before
> hv_vmbus loads, but I suppose this is not a real issue because hv_vmbus
> should never unload in practice. :-)

Thanks for the review.  Looking at this a bit more, ideally
hv_stimer_global_cleanup() should go away entirely.  vmbus_exit() should
let the call to cpuhp_remove_state() clean up the stimer on each CPU via=20
hv_synic_cleanup().   But vmbus_exit() shuts down the VMbus first, which
is really the wrong order.

As you say, vmbus_exit() never gets called in practice, so it's not a
current issue.  But I'll look at fixing this in a future patch so that it
makes logical sense.

Michael

>=20
> Tested-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

