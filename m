Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC862D037D
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Oct 2019 00:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfJHWlv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 18:41:51 -0400
Received: from mail-eopbgr1320107.outbound.protection.outlook.com ([40.107.132.107]:21230
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbfJHWlu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 18:41:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSUuo2VgmT4nw8G9AS3mzHxUPnIjum1zKfCcQu1d0jfxCtl7EBhWnQlAB1lfWiYviYrQMlRSH1bz+zfEfoYA41ts4ScsNjS39QhP8G7E3qaDfkfDzYZv/36jyuq8WXSAjU9jlfK8d3njvC75YwIWR9vpkJ24ruuiH9/koWghWtz+hRlaamVRfOsdb5wZz5abw+nCXeII7XWLNxXDFfupO/6Gv9bap7n0of4BelxuNNiOmHQ8rClPOpGXmzuQ8x0qnBFVWmG/b6giZnRSvTP4FvewSJRj0tM7oCARQIRJGhphOkQbJC7vff5P1C5BHOEUNu/P3qm7dPHHGOQXT0WViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6zBII0SwNq94zY8yUMMRz5K7UDSixzCAR8CBx+8L8g=;
 b=HCD/0mi+AKRZG6Ic5bB0F3ApRZYqg2YOeJPV8s2Ga/71jVfuZttK0LBAqwJE7hT5CGgU8U2hD+IS8ru6zPRyl/v+LO1ngJ9IM3L/d5altIoQQ2CM7dilgsUcX9z2zBPhM1bHdTl1T1KAkF9ikLpN0u/j/fQyA6wqQ1iYiraVqQm63PD4txHE+rgRmRbNOQqsOh3/h0UOP5OtUYwEcK4f4Po6aMNuvKVNkp1Rs9AU9rQCW/4ADjjG0MyHYpYH8jtytSSI+xJfNodS/WX4FxDFCLhKdnZY6Wo3d2u/MbGT4uqGFxtHRYJihzCwkvhO7EZoE7LR/2dyRuZLy/PkGzlKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6zBII0SwNq94zY8yUMMRz5K7UDSixzCAR8CBx+8L8g=;
 b=TRADYX6VxYkP0uXaf+VhxIfrLUt4OIKyLE1zFRf/qeYUlb8h6LUIgH9aKsQhvKZes0bYZhnzsKXzjU55mvTHp9h8BzuEEEFMlZU9s88OLeJ5rSCclS1rxiuZt8OPOJ8kSToyCTFaTWMC5G8jmAC4HrHAe7YK0tznd94RVOo6h/U=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0105.APCP153.PROD.OUTLOOK.COM (10.170.188.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.2; Tue, 8 Oct 2019 22:41:43 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2367.004; Tue, 8 Oct 2019
 22:41:43 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus protocol
 versions
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus
 protocol versions
Thread-Index: AQHVfdWxc5KO2kE/XECN2J8gzpV8GKdQtQiAgACTqLA=
Date:   Tue, 8 Oct 2019 22:41:42 +0000
Message-ID: <PU1P153MB0169B3B15DB8D220F8E1A728BF9A0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
 <20191007163115.26197-2-parri.andrea@gmail.com>
 <87eezo1nrr.fsf@vitty.brq.redhat.com>
 <20191008124052.GA11245@andrea.guest.corp.microsoft.com>
 <87zhibz91y.fsf@vitty.brq.redhat.com>
In-Reply-To: <87zhibz91y.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-08T22:41:41.2240349Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e204e5d4-6e59-4e12-8c5c-4c9533a3b816;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [167.220.2.148]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f114ef2c-6219-47cf-a9df-08d74c40b157
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0105:|PU1P153MB0105:|PU1P153MB0105:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01057A5F9DD7B0A941999371BF9A0@PU1P153MB0105.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(396003)(366004)(39850400004)(189003)(199004)(186003)(10090500001)(14444005)(102836004)(110136005)(4326008)(446003)(107886003)(486006)(33656002)(99286004)(52536014)(6506007)(8990500004)(22452003)(316002)(476003)(71190400001)(54906003)(25786009)(7696005)(305945005)(11346002)(55016002)(26005)(74316002)(6246003)(5660300002)(7736002)(256004)(10290500003)(71200400001)(76176011)(14454004)(81156014)(81166006)(229853002)(8676002)(86362001)(64756008)(6436002)(66946007)(66556008)(2906002)(478600001)(66446008)(3846002)(66476007)(6116002)(8936002)(76116006)(9686003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0105;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sUQjv+zo9VUZ89HsbeeS09oWvq4lcz1r5fy1HVeysWlfnyM1qfHQQ642+4V82DtT13AcSCz+ejzzuZGXhkhap1YpU1JiWc4xxlPbGo8Ohnb+sFXdPuMh3jNjXuyWWXRX1r+S/9j+tebW3xbV/JrA82wuIK0BamVV0nDHAab+/HkyTygPK1NczSzawzbpt1D2Nve3wd5whwTmPRH6ggWK76wV/94dfPNfBLr4CirIl+joFHOcWESXGoaDheFtNBWP+wFYR2eSi+IDzaAh4+9uxKbJtSgDBPCJr2uNomZkIrX1mfALZYsgHCJwJqVvT6kYFA/pTo44rij1Duf4mi8f9YL9u1jpzld2DnfHef/4u/nqEEZQIIWVr4Be+ughwH6hk5EUFCikF6zS1BABeOMMEZKLpSFIEX0Jg8788EkW7iE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f114ef2c-6219-47cf-a9df-08d74c40b157
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 22:41:42.8757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlsuFQBwGqqQiAdb/vi4hDrt6bZv01AjyD+FIfFuxCBYI78LZOZrBtvHRSKzLXhnzL60E+AiU2ozEN5y9/MhPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0105
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Tuesday, October 8, 2019 6:00 AM
>  ...
> > Looking at the uses of VERSION_INVAL, I find one remaining occurrence
> > of this macro in vmbus_bus_resume(), which does:
> >
> > 	if (vmbus_proto_version =3D=3D VERSION_INVAL ||
> > 	    vmbus_proto_version =3D=3D 0) {
> > 		...
> > 	}
> >
> > TBH I'm looking at vmbus_bus_resume() and vmbus_bus_suspend() for the
> > first time and I'm not sure about how to change such check yet... any
> > suggestions?
>=20
> Hm, I don't think vmbus_proto_version can ever become =3D=3D VERSION_INVA=
L
> if we rewrite the code the way you suggest, right? So you'll reduce this
> to 'if (!vmbus_proto_version)' meaning we haven't negotiated any version
> (yet).

Yeah, Vitaly is correct. The check may be a little paranoid as I believe=20
"vmbus_proto_version" must be a negotiated value in vmbus_bus_resume()
and vmbus_bus_suspend().  I added the check just in case.

> > Mmh, I see that vmbus_bus_resume() and vmbus_bus_suspend() can access
> > vmbus_connection.conn_state: can such accesses race with a concurrent
> > vmbus_connect()?
>=20
> Let's summon Dexuan who's the author! :-)

There should not be an issue:

vmbus_connect() is called in the early subsys_initcall(hv_acpi_init).

vmbus_bus_suspend() is called late in the PM code after the kernel boots up=
, e.g.
in the hibernation function hibernation_snapshot() -> dpm_suspend().=20

vmbus_bus_resume() is also called later in late_initcall_sync(software_resu=
me).

In the hibernatin process, vmbus_bus_suspend()/resume() can also be called =
a
few times, and vmbus_bus_resume() calls vmbus_negotiate_version(). As I
checked, there is no issue, either.

Thanks,
Dexuan
