Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA3B146313
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2020 09:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgAWILl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jan 2020 03:11:41 -0500
Received: from mail-eopbgr1320101.outbound.protection.outlook.com ([40.107.132.101]:47808
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbgAWILl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jan 2020 03:11:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T040e6oAiwo3sRUm08e6qC16ztB1d1pIomuEq6iO6+PUhXxYGMN5LarKKzLnOwX0Phpjisrx56qlbem5YVTZxRofpfvGMLc8bCo5bSSuPexKMo0/hCUtBurEVeAi5K/s4qU2EtMzuh0x/m8c/rumB/dg9I4PrwoEG9GSaZ7V9XR6IVHsO/3udiZpqqLQn07myIFDfWmB/C5JFzDj+60PkpE5KZDGf0X0N/9vnPlFBA83GXvHS+8Nszkv6ffi8TXKZpvB8WKhYS5oiBqJCea03iWT9f6sIlxoQ4cDgZMvN9iy3LCVtH+ZKgLr4zPAN2iHTaNl261E9oqpBziWSNksIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYiIAXMCRGL4ZDgH8cXtS9PjdvX/7APDAMcGohVbU5g=;
 b=JjusPkfSOsMNuDvWAczSSNifaiCK5oyqBPvJmgd3p6bCPhB5M7ga1wquBBXvgQKbH4D5Sy9SO3PffIA9tdAg/Fia9QnvWsru+1sfHAOnyZyrJfpFgXZmhoE+MQJ12i/GSbAIM5AVQ0X+QxAUN/pS5J+di9WBctqdsZKjCqj48ayPzuTS1zE/7obmNVEKfXfE04s563MoWAkRnIH5wttixph4+HXuKeDEXcLuwk1R5gSH4MFRpvweKwEvEchvKluagEJeDq6A4+Mu8rdrD3ECnJ0IY8j1rEewInmwf9OWO9TyXK9h1SgZAqXpMSoHV36Gf5DM7wlBENcqTnl83WslVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYiIAXMCRGL4ZDgH8cXtS9PjdvX/7APDAMcGohVbU5g=;
 b=g/0qMp0CijHgyPK1ArpeY8meMKWVZj9p6nbmfU97msnw8uEmT59hmCGH2vsE2LSOQ5a7EDET9Nj6opyCvXmarFSGXOykYArbOAawl9rHAGWmTK6aox3tCqMr3tRKqNMncaOJpSXwTu6RK1/UhGmF/QotzzwjQ9PTN7UNkuPgpUU=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0259.APCP153.PROD.OUTLOOK.COM (52.132.236.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.3; Thu, 23 Jan 2020 08:11:33 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%4]) with mapi id 15.20.2686.008; Thu, 23 Jan 2020
 08:11:33 +0000
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
Subject: RE: [PATCH v2 4/4] hv_utils: Add the support of hibernation
Thread-Topic: [PATCH v2 4/4] hv_utils: Add the support of hibernation
Thread-Index: AdXJ2zJbjzKVVIRATtCsfhHYStD+UQHcnlmwABw2wRA=
Date:   Thu, 23 Jan 2020 08:11:32 +0000
Message-ID: <HK0P153MB0148D8719B52A34BDB6C5836BF0F0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB0148B7D12E62DD559A5D2B9DBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <DM5PR2101MB104749677CD07DE42B5BD26DD70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB104749677CD07DE42B5BD26DD70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T06:32:21.2927925Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4db3c986-4f1e-4eb3-944c-2fd501d37986;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:21c4:4274:62b5:126b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72c5d336-c511-4837-0311-08d79fdbdbd8
x-ms-traffictypediagnostic: HK0P153MB0259:|HK0P153MB0259:|HK0P153MB0259:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0259F9EB4442B8F2D1E66DB5BF0F0@HK0P153MB0259.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(86362001)(10290500003)(110136005)(478600001)(186003)(8990500004)(81156014)(33656002)(81166006)(8936002)(8676002)(2906002)(7696005)(6506007)(966005)(5660300002)(71200400001)(66446008)(66556008)(55016002)(76116006)(66946007)(52536014)(64756008)(66476007)(316002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0259;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otLn8TL/VxefjbLX9LPhuAzfiLna3W7QN+Nf7G/KQQW1u/uD4qXyf6i+9s+saoUnzF07/kiyKGyJCwn4nt620T5k/1gIACPcgMFIQfd1rs5bhIFcOWii2oD7LXXSwkEFYtpkcpCyO930Sxk3iW4uSA9aEljK0SnHpYFY5SxF9ivSeFqZv5UlURKNFm9gfPik1rtTzXu6ko4d1+ISN1XZ926+4WYBy1RvdsOnR7PTGjHPHN3l1oaqHadeMYD7MnVxxCZhn464Ux1YTEGipfZVm9ZuejcubBJrsReSU/lm3ch1HaDVX9akmO2Z9ZZDF3XrtLKQH5+pr58QLrPgWUH/3r2IeJDDRKou3DRvPeZfBY4TSvZWszSlodOKsrfVklKASisdtLPj4sy9Y8E74VyqlP+i3hdvIVbzOmYEP0Q+7FtHOtk+G6rRoeZYN+G/KctXiPhRtI6Asd8zcM+qNZTCBGASFAg21DygG7acg41Veew=
x-ms-exchange-antispam-messagedata: iSjbpNdp0QegqFbhobqCll6QcyrUynNKuTncufoZm8MVydpGG4qMZH6Qo7WSIBxMU9DRrXPxdXL/z9F1mQ081MWh6SUsnRS5ok9O+af/iM0ZOvOWkRjjH1Nsb1iCe1Q8EtV3Ba7SPYGwRLMp146+tKdeXjFMUWccGQs+zlN4gChs6AWT7LZzT4wA+AetnkB21s+HpvyWD+O4n1gOQA3Feg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c5d336-c511-4837-0311-08d79fdbdbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 08:11:32.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6c5PMjbDu2DTVlWPy/Yp6E8wWY15itLotfeQwFE593nUX7/CGwkor968XIfBUhBZO2qYQURt+5VgqFYSj+azA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0259
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, January 22, 2020 10:28 AM
> ...
> > +int hv_fcopy_pre_suspend(void)
> > +{
> > +	struct vmbus_channel *channel =3D fcopy_transaction.recv_channel;
> > +	struct hv_fcopy_hdr *fcopy_msg;
> > +
> > +	tasklet_disable(&channel->callback_event);
> > + ...
> > +	fcopy_msg =3D kzalloc(sizeof(*fcopy_msg), GFP_KERNEL);
> > +	if (!fcopy_msg)
> > +		goto err;
> > +
> > +	fcopy_msg->operation =3D CANCEL_FCOPY;
> > +
> > +	hv_fcopy_cancel_work();
> > +
> > +	/* We don't care about the return value. */
> > +	hvutil_transport_send(hvt, fcopy_msg, sizeof(*fcopy_msg), NULL);
> > +
> > +	kfree(fcopy_msg);
> > +
> > +	fcopy_transaction.state =3D HVUTIL_READY;
>=20
> Is the ordering correct here? =20

This is intentional. I'll add a comment (please see the below).

> It seems like the fcopy daemon could receive
> the cancel message and do the write before the state is forced to
> HVUTIL_READY.

This can not happen, because when we're here from util_suspend(), all the
userspace processes have been frozen (please refer to another mail from me
https://lkml.org/lkml/2020/1/13/1021). The userspace is thawed only after
util_resume() and the other part of the resume procedure finish.

When we're here in util_suspend(), we can be in any of the below states:

#1: hv_utils has not queued any message to the userspace daemon.
Now hv_fcopy_pre_suspend() queues a message to the daemon, and forces
the state to HVUTIL_READY; the daemon should read the message without=20
any error; later when the daemon calls write(), the write() returns -1 beca=
use=20
fcopy_transaction.state !=3D HVUTIL_USERSPACE_REQ and fcopy_on_msg()=20
returns -EINVAL; the daemon responds to the write() error by closing and=20
re-opening the dev file, which triggers a reset in the hv_utils driver: see
hvt_op_release() -> hvt_reset() -> fcopy_on_reset(), and later the daemon
registers itself to the hv_utils driver, and everything comes back to norma=
l.

#2: hv_utils has queued a message to the userspace daemon.
Now hv_fcopy_pre_suspend() fails to queue an extra message to the=20
daemon, but still forces the state to HVUTIL_READY.

#2.1 the userspace has not read the message.
The daemon reads the queued message and later the write() fails, so the
daemon closes and re-opens the dev file.

#2.2 the userspace has read the message, but has not called write() yet.
The write() fails, so the daemon closes and re-opens the dev file.

#2.3 the userspace has read the message, and has called write().
This is actualy the same as #1.

So, IMO the patch should be handling the scenarios correctly.
=20
> > +
> > +	/* tasklet_enable() will be called in hv_fcopy_pre_resume(). */
> > +
> > +	return 0;
> > +err:
> > +	tasklet_enable(&channel->callback_event);
>=20
> A nit, but if you did the memory allocation first, you could return -ENOM=
EM
> immediately on error and avoid the err: label and re-enabling the tasklet=
.

Good idea! I'll fix this.

> > +	return -ENOMEM;
> > +}
> > ...
> > --- a/drivers/hv/hv_snapshot.c
> > +++ b/drivers/hv/hv_snapshot.c
> > @@ -229,6 +229,7 @@ static void vss_handle_request(struct work_struct
> *dummy)
> >  		vss_transaction.state =3D HVUTIL_HOSTMSG_RECEIVED;
> >  		vss_send_op();
> >  		return;
> > +
>=20
> Gratuitous blank line added?

Will remove it. I probably tried to make the "return;" more noticeable.=20
=20
> >  	case VSS_OP_GET_DM_INFO:
> >  		vss_transaction.msg->dm_info.flags =3D 0;
> >  		break;
> > ...
> > +int hv_vss_pre_suspend(void)
> > +{
> > ...
> > +	/* We don't care about the return value. */
> > +	hvutil_transport_send(hvt, vss_msg, sizeof(*vss_msg), NULL);
> > +
> > +	kfree(vss_msg);
> > +
> > +	vss_transaction.state =3D HVUTIL_READY;
>=20
> Same comment about the ordering.

I'll add a comment for this. I may add a long comment in util_suspend()
and add a short comment here.

> > +
> > +	/* tasklet_enable() will be called in hv_vss_pre_resume(). */
> > +
> > +	return 0;
> > +err:
> > +	tasklet_enable(&channel->callback_event);
> > +	return -ENOMEM;
>=20
> Same comment about simplifying the error handling applies here.

Will fix this.
=20
> > +static int util_suspend(struct hv_device *dev)
> > +{
> > +	struct hv_util_service *srv =3D hv_get_drvdata(dev);
> > +	int ret =3D 0;
> > +
> > +	if (srv->util_pre_suspend) {
> > +		ret =3D srv->util_pre_suspend();
> > +
>=20
> Unneeded blank line?

Will remove this.

> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	vmbus_close(dev->channel);
> > +
> > +	return 0;
> > +}
> > +
> > +static int util_resume(struct hv_device *dev)
> > +{
> > +	struct hv_util_service *srv =3D hv_get_drvdata(dev);
> > +	int ret =3D 0;
> > +
> > +	if (srv->util_pre_resume) {
> > +		ret =3D srv->util_pre_resume();
> > +
>=20
> Unneeded blank line?

Will remove this.

Thanks,
-- Dexuan
