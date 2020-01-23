Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8985D14630F
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2020 09:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgAWILQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jan 2020 03:11:16 -0500
Received: from mail-eopbgr1320090.outbound.protection.outlook.com ([40.107.132.90]:63552
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbgAWILQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jan 2020 03:11:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOUep5owFW6oSNrwfQEiBkcAtSxYx57Xj55bqzrRKCOV7onAVpKxlPp6GI/1Esukivb20dBdmeaJYPz0yozQ9yUMCHm4qubmVGNSwBPRKhOit7o1sKvcGBo1grF5ZEiGqW/JC0yW8TEmDBHL2YqHhddrEFNcwDS4ds1UPhfl0NcKsEGrUjeluc69YaHOr41ORrWqwkKkSdcVo4D2ZCEHMhkRyPVCvtBpMITKS+GPmb87kPI/B2CyaFcOPwyxTHLGxPcZyysaa0f7epCloiWOQNIZ+fzISk6aOXlTy06MKAqFhKQUCzWdL7k7FmL/rJLuokyWGPECXX4oyfuwdcIZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQDtjWluFNvMTlHJXkaL7iG/LraodMQKiHR1lLD8a/w=;
 b=JrrEcUcX+KSRRa7xMD1sFdQbxYjlpj1Jhjr7tvRsZNDh7QMh+NIxS0PMhq0p3f3lhi4HsC737G57lPcwQyUqKb6TaXoM+3NXFdQ0QfyTfRJ1p9cjiIup6fN3J80Kq8UaxaW5agfugjjz32FttrLoefyI7URH7uXW8LQ5JcnR38Iqck2BB0nkCKQvCuVJ4Fbh7rRnhRgXrrOhSc56q1yvPsAkmbi+IclXbSY1JCGjWuzfOqJi1VXBwCWxelP57UCC1G+vOXTNzIyrDX8nkzt02fvSAF+nOak+Y7jwFBo3A1C2N4YoD3WS1kObKdECR2x9NYtHcaa7yIYs7CQrrrAkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQDtjWluFNvMTlHJXkaL7iG/LraodMQKiHR1lLD8a/w=;
 b=QS8glqNkYn0YWb/n3Lou9zMVpk3icfk1VfRx58TGparTXsz+hnq8PnY4L8gKNSih8Tq8jGf7WHcwFdH9VHEbvVLCNbiUgkOgYmg8O1HvHTJtGkB9Os1xLSs21cz7hqDsnFVebUoEWxcpKvp/xpxuHKmHySC4Bo0pVrZhovPcscI=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0259.APCP153.PROD.OUTLOOK.COM (52.132.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Thu, 23 Jan 2020 08:11:09 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%4]) with mapi id 15.20.2686.008; Thu, 23 Jan 2020
 08:11:09 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] hv_utils: Support host-initiated restart request
Thread-Topic: [PATCH v2 2/4] hv_utils: Support host-initiated restart request
Thread-Index: AdXJ2v+CkGXQwSJARV+SWgYtZDG50AHatmlAAB0ezrA=
Date:   Thu, 23 Jan 2020 08:11:09 +0000
Message-ID: <HK0P153MB0148AC826E1507D92A6E8BFABF0F0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB01487F54363A856730BB13FDBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <DM5PR2101MB104763C3447F4BB9C163F8F0D70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB104763C3447F4BB9C163F8F0D70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:30:56.6858983Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6a12eb12-6152-4624-a9ab-f6645601545c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:21c4:4274:62b5:126b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8c22345-28dd-4f03-3864-08d79fdbce02
x-ms-traffictypediagnostic: HK0P153MB0259:|HK0P153MB0259:|HK0P153MB0259:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0259AFDF493D7AD648F4AF1DBF0F0@HK0P153MB0259.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(86362001)(10290500003)(110136005)(478600001)(186003)(8990500004)(81156014)(33656002)(81166006)(8936002)(8676002)(2906002)(7696005)(6506007)(5660300002)(71200400001)(66446008)(66556008)(55016002)(76116006)(66946007)(52536014)(64756008)(66476007)(316002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0259;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VutrtvtkOZZ1ODoxIopatCvmdoHGv6Xo0dJj5ZaQMI0xcujwXnAGQpbJH632B0vskNYYJgPLpqgACE18J/vA/lfUKRlMwL8ylavkfrG/EdcOJT+wMqfb3EZjxQMjwpXoyccx5Yld4w7Q4bphfdwi+4L/WV1uUSKfOjppTTnyZ3h+mQucxhngfVw91CZP07+q6ZbUKrF4FhMzRR64MqD/+DnbGbQPkta2KG/GLe6EPIh7BbPzrC1y2uJdiPvvJdg8VdzwFnvgJlfBvA+Xy9SvhNrbBNlXH6HtaU6VBaavhu413sB40caLZpVb168IJ4N2I7BD5RKPsy8oHj4RBtMPx5lKeRUNX402DNT32ZetPd9qo4/f3GtoLKcJ+/VRKX7aO3wyUxeiYz2vjniSh8HA7yaEwBijgvo4+eqx/CYKjwF59fL5oRivrofYyY4N7uaQ
x-ms-exchange-antispam-messagedata: Ll4TgjcCWVbow7Fmmtofd9brLAec/+XLQcfr3fBp7ip8ifBvWD39/5xq+vfFg9IagDwwDjRR39genQmK9WXwmgt0vGL78SKIttmHX5nFj5EVsW85R+rbK0X13GB/rFn9wPvMOl1TlIMV+Uv/beLRR6RwwUoF1FPmRgt6P6lvhPM4w/59NFBJC02JsN80GQ8Qn9VPXRE5ns121GIyfNgfeQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c22345-28dd-4f03-3864-08d79fdbce02
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 08:11:09.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpPrZcxqXMvKP0VpYG3e5dla0lsl22J16u8eRl455lpQkf7W2eiD9elTpi3zvXzsvy/BzxA/kPvzLzzRY2pQ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0259
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, January 22, 2020 9:16 AM
> >
> > To test the code, run this command on the host:
> >
> > Restart-VM $vm -Type Reboot
>=20
> Need a better commit message here.  How about:
>=20
> The hv_util driver currently supports a "shutdown" operation initiated fr=
om the
> Hyper-V host.  Newer versions of Hyper-V also support a "restart" operati=
on.
> So add support for the updated protocol version that has "restart" suppor=
t, and
> perform a clean reboot when such a message is received from Hyper-V.
>=20
> To test the restart functionality, run this PowerShell command on the Hyp=
er-V
> host:
>=20
> Restart-VM  <vmname>  -Type Reboot

Thanks a lot! I'll use this version.=20

> > @@ -166,6 +179,14 @@ static void shutdown_onchannelcallback(void
> *context)
> >  				pr_info("Shutdown request received -"
> >  					    " graceful shutdown initiated\n");
> >  				break;
> > +			case 2:
> > +			case 3:
>=20
> How are the flags values 0, 1, 2, and 3 interpreted?  Perhaps a short com=
ment
> would be helpful.

If bit 0 is 1, it means a flag of "doing the operation by force".  IMO we'd=
 like to
always perform the operation by force, even if the host doesn't set the fla=
g -- this
is what the existing shutdown handling code does.

I'll add a comment.

>=20
> > +				pr_info("Restart request received -"
> > +					    " graceful restart initiated\n");
> > +				icmsghdrp->status =3D HV_S_OK;
> > +
> > +				schedule_work(&restart_work);
> > +				break;
>=20
> For case 0 and 1 (shutdown), the schedule_work() call is performed only
> after the response packet has been sent to the host.  Is there a reason t=
he
> new code for case 2 and 3 (restart) is doing it in the opposite order?

The channel callback runs in a tasklet context, and an active tasklet handl=
er can
not be cancelled, so even if the "work" starts to run on another CPU immedi=
ately,
I'm sure the channel callback will send the response packet and finish norm=
ally.

This way we can save a local bool variable "execute_reboot". :-)

But, let me change the patch to follow the shutdown handling code for
consistency.

Thanks,
-- Dexuan
