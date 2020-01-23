Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09837146CE9
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jan 2020 16:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgAWPdU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Jan 2020 10:33:20 -0500
Received: from mail-eopbgr690125.outbound.protection.outlook.com ([40.107.69.125]:14211
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgAWPdU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Jan 2020 10:33:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt+lDMKt4oaYvDhgGQQbw+23LBb3kFqAmi4MJZw+g26BdTwT5WMLFir8mEaK52g7vuXRO0pUW5+cY/2tYgTKqRDmN/t2ORdUtHxKnIyCHwvS/PKd3cnZEMifqfsv/WYBvD3774dDgTG62tLt+R4gKCOwUTEqYqm+Bg0yDVdhwWchcESQ5bImfCkgfEhOQhjmgHet/DECUXgmj/b8jMwWYfEpo9A/Idm298HT05A4OiST93Y8giPCD198TMWneLj8aO4TynzDGyWlkk8zQs4i/3ckVHeiT5MAW3N71FInvFjIq6vkY/Nezq89KY5rz96vZ7Myr5Pp5j1rJOG99/Zhcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/0Qbel0ga/KloZLsV8VrKwLLcIwP2Zn250mUTwY+mA=;
 b=T9shHAXLQiUUq5B2X7+mi9nFaukFI7KFO/dXsKii7kKupUDLJbAthZkxDFG2esxWKgqS41LjV48/9NBI3a00di96gHyTwO2zLLzmmW/js5eevTtbcEWOlX1dRphdxdqIIAKs+aTrMcNBrw9gf6lXijDveEkkS/iQrOU9ZO07Mmwyho1HRjtbZZuV7/PW1Ix5rD7pqV4W4iRuJrNBQU/7YS9INM5g948PgzSCFQDOOyOvBp564JyBqF/XTo7gsjy+fpYCgw69Yvmaqa4vGlHLiwm6d9E8W+HpktMmWvsAQ/UNWHAm2DO9cdn1/kre9cKU0NbFp2n272IA3hUTQyHyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/0Qbel0ga/KloZLsV8VrKwLLcIwP2Zn250mUTwY+mA=;
 b=Qv6S5EpA1KNKFaPSSYYg9tzn8z5qAF2zJr7wHFazHG2PUSbYe6YLrJo4CD4y6oq+jQK6JcCbZ04bYLkbgotMkDtN0vESyyxP84oRwuL9OSpm0cqv6pj/OBoWVnYLkKnRiOrQlAitdrcfM/3ptOz0GnFMhiy0xG7h98supN3yf+4=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB1034.namprd21.prod.outlook.com (52.132.149.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.11; Thu, 23 Jan 2020 15:31:33 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d561:cbc4:f1a:e5fe%9]) with mapi id 15.20.2686.013; Thu, 23 Jan 2020
 15:31:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
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
Thread-Index: AdXJ2zJbjzKVVIRATtCsfhHYStD+UQHcnlmwABw2wRAAENc88A==
Date:   Thu, 23 Jan 2020 15:31:32 +0000
Message-ID: <MW2PR2101MB10527A8CE238574D2FAF22F4D70F0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <HK0P153MB0148B7D12E62DD559A5D2B9DBF350@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <DM5PR2101MB104749677CD07DE42B5BD26DD70C0@DM5PR2101MB1047.namprd21.prod.outlook.com>
 <HK0P153MB0148D8719B52A34BDB6C5836BF0F0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <HK0P153MB0148D8719B52A34BDB6C5836BF0F0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
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
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02cb47ea-c3b7-43e5-7b00-08d7a0195377
x-ms-traffictypediagnostic: MW2PR2101MB1034:|MW2PR2101MB1034:|MW2PR2101MB1034:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1034509C4D184BF64723C1D2D70F0@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(86362001)(5660300002)(8676002)(2906002)(52536014)(8936002)(81156014)(81166006)(8990500004)(55016002)(110136005)(33656002)(66946007)(10290500003)(76116006)(7696005)(316002)(966005)(6506007)(66446008)(66556008)(186003)(478600001)(66476007)(9686003)(71200400001)(64756008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hP91KjsWuAsQ75RrTRIicZ4FoQIgFQXR44D+zsXkdKgYen966hY0BFpmWjJD7M9Np3T06zMRRenGysijsStNyXUhLpF2POMVAAQKjmdYRi6waGc6svH3ctnqH97+U586Np10xzp/fYjEv3Auk5ZRpe2adrPmJV3z6xTY9fwJFofXWbdTfMD3tGYBwMi8fRmpN9UmipxRb6Zd4ByhUQ9T9G/h94Q0bJukm5qTn732OrvC7W1z7A3BmBL0siRyMcK0uffoUsXwA63pC1yUll/S1XnqVw+xmdiD5grbhCTAGeXouDN7I/rXkVOlRcEnCK4jf3AYStmWuFIl0xRYdevUpjbfw9vavHCrXPrdNO5Udn24wfOFi5n4cW4nqE1Puu9BFO/EkQQiU3inM46lmCx9Ba30x4aWC5Cp6E7F6Vmnw1CFDt0DkhZtf47sBjs08uIt1osr2EiuuxQ7CT4peeSIE1UwWaGmSMsUMs9v4mDJwbc=
x-ms-exchange-antispam-messagedata: rWVR2PEm6dVqfvQFv3BKxI2mn+zbkrA+O3wfRGj/NNcr3AiUyCq0gtQQaHryThT3ahW/ZZfHC2oUKtkabPz052dlaKGzjp0+fkRsXL4qRqeO6q1n6nDcm8M4vougXz18tDfwp3YjL3xopgucFEBB+A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cb47ea-c3b7-43e5-7b00-08d7a0195377
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 15:31:32.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJaFoE/uEdNA3d/doIixrrKC64y85+HRmmwUA2aR9vz6TMwllznOaAIpX0BizxJk7RSYnBh8BDh8AcG9izRvJZbtdHbfE76UkoljUcjImOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, January 23, 2020 12:=
12 AM
>=20
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Wednesday, January 22, 2020 10:28 AM
> > ...
> > > +int hv_fcopy_pre_suspend(void)
> > > +{
> > > +	struct vmbus_channel *channel =3D fcopy_transaction.recv_channel;
> > > +	struct hv_fcopy_hdr *fcopy_msg;
> > > +
> > > +	tasklet_disable(&channel->callback_event);
> > > + ...
> > > +	fcopy_msg =3D kzalloc(sizeof(*fcopy_msg), GFP_KERNEL);
> > > +	if (!fcopy_msg)
> > > +		goto err;
> > > +
> > > +	fcopy_msg->operation =3D CANCEL_FCOPY;
> > > +
> > > +	hv_fcopy_cancel_work();
> > > +
> > > +	/* We don't care about the return value. */
> > > +	hvutil_transport_send(hvt, fcopy_msg, sizeof(*fcopy_msg), NULL);
> > > +
> > > +	kfree(fcopy_msg);
> > > +
> > > +	fcopy_transaction.state =3D HVUTIL_READY;
> >
> > Is the ordering correct here?
>=20
> This is intentional. I'll add a comment (please see the below).
>=20
> > It seems like the fcopy daemon could receive
> > the cancel message and do the write before the state is forced to
> > HVUTIL_READY.
>=20
> This can not happen, because when we're here from util_suspend(), all the
> userspace processes have been frozen (please refer to another mail from m=
e
> https://lkml.org/lkml/2020/1/13/1021). The userspace is thawed only after
> util_resume() and the other part of the resume procedure finish.

Oh, right.  That makes sense now.

>=20
> When we're here in util_suspend(), we can be in any of the below states:
>=20
> #1: hv_utils has not queued any message to the userspace daemon.
> Now hv_fcopy_pre_suspend() queues a message to the daemon, and forces
> the state to HVUTIL_READY; the daemon should read the message without
> any error; later when the daemon calls write(), the write() returns -1 be=
cause
> fcopy_transaction.state !=3D HVUTIL_USERSPACE_REQ and fcopy_on_msg()
> returns -EINVAL; the daemon responds to the write() error by closing and
> re-opening the dev file, which triggers a reset in the hv_utils driver: s=
ee
> hvt_op_release() -> hvt_reset() -> fcopy_on_reset(), and later the daemon
> registers itself to the hv_utils driver, and everything comes back to nor=
mal.
>=20
> #2: hv_utils has queued a message to the userspace daemon.
> Now hv_fcopy_pre_suspend() fails to queue an extra message to the
> daemon, but still forces the state to HVUTIL_READY.
>=20
> #2.1 the userspace has not read the message.
> The daemon reads the queued message and later the write() fails, so the
> daemon closes and re-opens the dev file.
>=20
> #2.2 the userspace has read the message, but has not called write() yet.
> The write() fails, so the daemon closes and re-opens the dev file.
>=20
> #2.3 the userspace has read the message, and has called write().
> This is actualy the same as #1.
>=20
> So, IMO the patch should be handling the scenarios correctly.
>=20
> > > +
> > > +	/* tasklet_enable() will be called in hv_fcopy_pre_resume(). */
> > > +
> > > +	return 0;
> > > +err:
> > > +	tasklet_enable(&channel->callback_event);
> >
> > A nit, but if you did the memory allocation first, you could return -EN=
OMEM
> > immediately on error and avoid the err: label and re-enabling the taskl=
et.
>=20
> Good idea! I'll fix this.
>=20
> > > +	return -ENOMEM;
> > > +}
> > > ...
> > > --- a/drivers/hv/hv_snapshot.c
> > > +++ b/drivers/hv/hv_snapshot.c
> > > @@ -229,6 +229,7 @@ static void vss_handle_request(struct work_struct
> > *dummy)
> > >  		vss_transaction.state =3D HVUTIL_HOSTMSG_RECEIVED;
> > >  		vss_send_op();
> > >  		return;
> > > +
> >
> > Gratuitous blank line added?
>=20
> Will remove it. I probably tried to make the "return;" more noticeable.
>=20
> > >  	case VSS_OP_GET_DM_INFO:
> > >  		vss_transaction.msg->dm_info.flags =3D 0;
> > >  		break;
> > > ...
> > > +int hv_vss_pre_suspend(void)
> > > +{
> > > ...
> > > +	/* We don't care about the return value. */
> > > +	hvutil_transport_send(hvt, vss_msg, sizeof(*vss_msg), NULL);
> > > +
> > > +	kfree(vss_msg);
> > > +
> > > +	vss_transaction.state =3D HVUTIL_READY;
> >
> > Same comment about the ordering.
>=20
> I'll add a comment for this. I may add a long comment in util_suspend()
> and add a short comment here.
>=20
> > > +
> > > +	/* tasklet_enable() will be called in hv_vss_pre_resume(). */
> > > +
> > > +	return 0;
> > > +err:
> > > +	tasklet_enable(&channel->callback_event);
> > > +	return -ENOMEM;
> >
> > Same comment about simplifying the error handling applies here.
>=20
> Will fix this.
>=20
> > > +static int util_suspend(struct hv_device *dev)
> > > +{
> > > +	struct hv_util_service *srv =3D hv_get_drvdata(dev);
> > > +	int ret =3D 0;
> > > +
> > > +	if (srv->util_pre_suspend) {
> > > +		ret =3D srv->util_pre_suspend();
> > > +
> >
> > Unneeded blank line?
>=20
> Will remove this.
>=20
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	vmbus_close(dev->channel);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int util_resume(struct hv_device *dev)
> > > +{
> > > +	struct hv_util_service *srv =3D hv_get_drvdata(dev);
> > > +	int ret =3D 0;
> > > +
> > > +	if (srv->util_pre_resume) {
> > > +		ret =3D srv->util_pre_resume();
> > > +
> >
> > Unneeded blank line?
>=20
> Will remove this.
>=20
> Thanks,
> -- Dexuan
