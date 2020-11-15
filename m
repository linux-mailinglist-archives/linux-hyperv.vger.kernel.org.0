Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E792B39CE
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 23:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgKOWPS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 17:15:18 -0500
Received: from mail-eopbgr750111.outbound.protection.outlook.com ([40.107.75.111]:20067
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbgKOWPS (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 17:15:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki93NhroKj/Lv6SiiQYDgS6mzhtUnRGw1pXe6qD0meNFvP986qmlvWVtyzeY4OmULxbeWVkB33cRqb35pHrWCIMuTmf45AIjMWDWRD2DWmFjZWyYY3YvpgFpAHNAH643Iy5kdEvtld7gaxmM+9lNKGXiW6mNEd6yXokBb3rSOaSgFG2TVWsY0JUpTTVbT91vDOiCSr94fISUGECqYtLX7+K1R5pnIi1XA8KwtaBzEAR3VzfGqR6hcG/3iYJiPfJu4bW5XBeN9H1rgZeC2hMdHhcWMfjY+DNgAAbof+OyJenifzIFpfBYfIW2sWhi0relu8DZ+fam/66JIdVMkilpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QU4oGIWraGhNGBiFhlf8DQco+6gpRCcJJvlhQL+sFPg=;
 b=BvcvQRbTQc9+rG7QW4MazGOx2TfCoJ0FxhBup7uqyvFe4KTwLKohBZbvIB2N5VfDxQWxfXyqo2g9M6Ui4es9o/Om2PsixWtTOocn/FwjfUtPgZqhWC65pvCX25a/eJ7pCnuoT3d9bfahaTBISg57dsV48S2Dvu+cBkW3LIkFgo6cvY1ipgFHwLRRzPjIxCZym9lBr04UHPG5PWV/vxpmqzfUAgnsN3QWGR2T8HqFIBKtH0AMH0sgYgFwZTkfQqSMOiNRiRZ2i9/pkjtRmnN09H9irpiRVnbAd8CkIwJTgsFCMgjr2SgxcBP6VMpcw07lHit6/H+zb6VOLY3LtfYnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QU4oGIWraGhNGBiFhlf8DQco+6gpRCcJJvlhQL+sFPg=;
 b=Keer20It+BRIn0p3iKoJsK4k4Pc1uoW5jWTHhL2VEntoa9hTrnWEr1G/Wnnv/KkM0mEjcEtpZ2edYcFkdjly4EeagstqY4ghiz/GFx1NLf6qKueUVB6Fsup3vm50uFg7iFGJRMlzyhYhGyPlyQm2LGvzAiEJ62E71bEjsAI2Xh4=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0890.namprd21.prod.outlook.com (2603:10b6:302:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Sun, 15 Nov
 2020 22:15:02 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%9]) with mapi id 15.20.3564.021; Sun, 15 Nov 2020
 22:15:02 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Matheus Castello <matheus@castello.eng.br>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "sashal@kernel.org" <sashal@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/6] drivers: hv: vmbus: Replace symbolic permissions by
 octal permissions
Thread-Topic: [PATCH 2/6] drivers: hv: vmbus: Replace symbolic permissions by
 octal permissions
Thread-Index: AQHWu4mpNZcOG4SEKk2k9sOyR1R2aqnJwgyA
Date:   Sun, 15 Nov 2020 22:15:01 +0000
Message-ID: <MW2PR2101MB1052E58FC2A195EDB723B2DDD7E40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201115195734.8338-3-matheus@castello.eng.br>
In-Reply-To: <20201115195734.8338-3-matheus@castello.eng.br>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-15T22:15:00Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=128fdc9f-c3ea-48d4-8b40-75a25dc956b7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: castello.eng.br; dkim=none (message not signed)
 header.d=none;castello.eng.br; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e023942a-5d7c-40a5-2135-08d889b3e5ce
x-ms-traffictypediagnostic: MW2PR2101MB0890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB08905B90F9D27DF75E91370CD7E40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:269;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: buneT61BXJ0oHuYQyvoUL1XrBvSDGTaz8EC28PRRo3nIWnPYiz3SugMA5IRaiz1OLj6abLj6Ig8eSdLfKor/4VCTf7uKiHDo0apjKFLjKggpIyUmFV7Nl/XK2HsdtolqvkyZYQQlNyn70OT29m5yBuDgkmAGwzpylaF4pUPLzpvf0/92zQkErQBCvQVLMMhjDPH2V6TuLuyElg0O5AkUXravTbH3OYjRilbhnI4qAXu/mhr+E9Q7EJbRw1kX4dVZBg9VpjtV2SdBJ/k8+WPNSb6AY9wRfGHBOkxORClMnolYcC0mPouZlKR60T4ZMsWZpHSyQpUyp1Et2ey7FKbiKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(33656002)(6506007)(54906003)(110136005)(71200400001)(55016002)(86362001)(8936002)(66946007)(52536014)(26005)(8676002)(10290500003)(82960400001)(66476007)(316002)(8990500004)(66556008)(7696005)(64756008)(82950400001)(4326008)(478600001)(186003)(2906002)(5660300002)(76116006)(9686003)(83380400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lAaT3r7HS1cZaKlHxiQoqLE7FJ9tTiGRiDpZhZgpXvLKuEZsUq0Yvd0sSUvaqpuTUWjMwJc+y9Xcv5dcq1s5fKDwRAyCPZaof5VZ7izAmEXxBIqNeNnyMUONfuM6nNdcQtgIqtC0sPImhWUnoenj9d+OrVVIa0rSR3jGvaeE55cOtx+ZWB6wp1712sjRbGNSn1VWnR16/QQMLWE418hqD7I2DUl3fVXpfxgfT8dRV9ROb2Uxtk+XG5F1KvHkRbMcce+dKtZo1Pi7ul3+m/xUzH/0OL2ZV26Dzxe7bKq7D68F8itswedxJ6PSQHtEkiNVWZsZd6yihPEYuw3eS8SlsfZVAJHYShlvCzd6vFIqYgn+yLgobsRyDqRzEJJGYt5k5AzlFHu1R7FOY2u2nexWmodYcBaVU2ZIZMjamUafV3VjsEj5p0NQBP5h810GV8nCb7g6zQSsEF2pwr/Eob+n7bJyxO+uNlDhLqvf+kHKWDGLjvysBMukbvggz8IHKux/PHPgvlP5OjomxaqYHhbRTQUm69Ap/NsfUDuESBg4Mob1R7A5+f9Vex+F1piHQTxDhaoARqPyiC1pMMksC3O4SjMfHThNPdYoXR4l9Fv0R1wPL/+OMAxvauXjgNLpPMS36khLDXdA0jIdDjU9crKQOm0gQhRJQgeWSuMpxc0dAK8JcuUDL2ue+RcVx0xazrso5+GQvC9JHKXuPyWhb+4EvCgz7ckOAJkLrDB2+Qm+1LIkVNfh7Pi8/G5BBItPwh/l8T9MAWmdRP9XWU6Eng02w8ZavKS6DniLlzzGtbU3eYfmyeAeHPc3huqlnfWm7gIzpzatlRr7Qmer2W2toB4Jdvz92pCILNO499sxZu4ZKMLoOoJZQKcxgLovzY6xSAS3CVfwSCqhOglgRJBUjNXVjA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e023942a-5d7c-40a5-2135-08d889b3e5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2020 22:15:01.8519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Emqd8Xqcd0SnxUth4KSJWE/GgyKTmJYiPvrE6+1tRXCouQD8T3GYx/zmq2w+EuNtBgsUtbVFa+Xw5+wjqSd4C02J5HdvHC5us88IPj6uOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Matheus Castello <matheus@castello.eng.br> Sent: Sunday, November 15,=
 2020 11:58 AM
>=20
> This fixed the below checkpatch issue:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred.
> Consider using octal permissions '0444'.
>=20
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/hv/vmbus_drv.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 9ed7e3b1d654..52c1407c1849 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1812,7 +1812,7 @@ static ssize_t channel_pending_show(struct vmbus_ch=
annel
> *channel,
>  		       channel_pending(channel,
>  				       vmbus_connection.monitor_pages[1]));
>  }
> -static VMBUS_CHAN_ATTR(pending, S_IRUGO, channel_pending_show, NULL);
> +static VMBUS_CHAN_ATTR(pending, 0444, channel_pending_show, NULL);
>=20
>  static ssize_t channel_latency_show(struct vmbus_channel *channel,
>  				    char *buf)
> @@ -1821,19 +1821,19 @@ static ssize_t channel_latency_show(struct vmbus_=
channel
> *channel,
>  		       channel_latency(channel,
>  				       vmbus_connection.monitor_pages[1]));
>  }
> -static VMBUS_CHAN_ATTR(latency, S_IRUGO, channel_latency_show, NULL);
> +static VMBUS_CHAN_ATTR(latency, 0444, channel_latency_show, NULL);
>=20
>  static ssize_t channel_interrupts_show(struct vmbus_channel *channel, ch=
ar *buf)
>  {
>  	return sprintf(buf, "%llu\n", channel->interrupts);
>  }
> -static VMBUS_CHAN_ATTR(interrupts, S_IRUGO, channel_interrupts_show, NUL=
L);
> +static VMBUS_CHAN_ATTR(interrupts, 0444, channel_interrupts_show, NULL);
>=20
>  static ssize_t channel_events_show(struct vmbus_channel *channel, char *=
buf)
>  {
>  	return sprintf(buf, "%llu\n", channel->sig_events);
>  }
> -static VMBUS_CHAN_ATTR(events, S_IRUGO, channel_events_show, NULL);
> +static VMBUS_CHAN_ATTR(events, 0444, channel_events_show, NULL);
>=20
>  static ssize_t channel_intr_in_full_show(struct vmbus_channel *channel,
>  					 char *buf)
> @@ -1872,7 +1872,7 @@ static ssize_t subchannel_monitor_id_show(struct
> vmbus_channel *channel,
>  {
>  	return sprintf(buf, "%u\n", channel->offermsg.monitorid);
>  }
> -static VMBUS_CHAN_ATTR(monitor_id, S_IRUGO, subchannel_monitor_id_show, =
NULL);
> +static VMBUS_CHAN_ATTR(monitor_id, 0444, subchannel_monitor_id_show, NUL=
L);
>=20
>  static ssize_t subchannel_id_show(struct vmbus_channel *channel,
>  				  char *buf)
> --
> 2.28.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

