Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2696B3B48DC
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jun 2021 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFYSlh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Jun 2021 14:41:37 -0400
Received: from mail-oln040093003013.outbound.protection.outlook.com ([40.93.3.13]:61078
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229531AbhFYSlh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Jun 2021 14:41:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lemd7dk56MIztj54woEjZFAGW0XXyUlA+uD7AqWYbWKNEX/ZOZj3dEk5JSOFivBSv9c6V+iZmIxSVYkOabnU2j5dKnAQ6dnz+WhHBs19/ROaxtS5rrOvGzUZ7yNd8Q9f4CsyVDfSzw2FZsTexlPK8xa8L9Yo0ntQM1NuVyIcYz3vlZd0hFKzz8DB5mbs3+jzMbOvz+YzTeDmitNOirpX4fUENYFx26Bh/zih1g+g7qIzfrzRM/PRN8dOGmnFCPOtAiYBHkryoh7Q0OzBma3zzN9ZQfZfpRcKCwcjRdS94dVRuQMgy6ZtbAvDJkaf7Y1YEZGTqSIL/wPRvxQFW3R3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeWMLISuchs2d2NtbUU9w9c5BcCg2a2qFkBy8fJ2k0Q=;
 b=T/s7wUdXfvkZOUaPMaa4h22ToeOaEUtWwLgqdOcwelyRWQOAdKjpz5V/aaMw38AET9shdQwAhGS1kEidAyz43QQm6QulLxEesjKnVdnSp+Z4JU5X1tKNLvFo4AnteRZq9G66NQkukRYYbkZQjddlZMsohhDs99u0iAheF885Xh89nIN8wQ85oCCHzCp/Ev6c23yEWfpsBO5tSkAISkZuF9+gYR1tvTnyGRLO6BrLksm7ZSdF+kgfidPdbZgpB/1QBCOHjOlyYXGAEKBVoVQWsWFSj9QFfqyM2/Buhu/JxXTHHWEZD3mkbAK9LZTgfc24rd66Fzzi+yzVypFoKyWrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeWMLISuchs2d2NtbUU9w9c5BcCg2a2qFkBy8fJ2k0Q=;
 b=Z04Wqcci8LLa4MbTkVvaTj9k17iruNK/oe+myXY5cEwVSdpHhDr2oWToadREozf9yT53APmydehhfWpCkYeNghIdZJ4BF5wx2/+PoH1sSYGPPi1cr75b8wSgoeKrmt2rD5zHHBCuOkFugtxNVZhcZUVxayDsUZPZGEqIm8Lh998=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1034.namprd21.prod.outlook.com (2603:10b6:302:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.7; Fri, 25 Jun
 2021 18:39:13 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b838:6cc7:4c40:fe99]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::b838:6cc7:4c40:fe99%7]) with mapi id 15.20.4287.014; Fri, 25 Jun 2021
 18:39:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
Thread-Topic: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
Thread-Index: AQHXXAJLl0OGg22fU0mIFDqhwVn9YascP8mQgAXSAQCAAB+fIIAAHVEAgALXDTA=
Date:   Fri, 25 Jun 2021 18:39:12 +0000
Message-ID: <MWHPR21MB15938FD090DDD7BBA186EFAAD7069@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
 <1623114276-11696-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15931C10916D27DB73CA5026D70A9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506187A82B88BBFECB2A884CE089@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593A5DE463C2DC61586ACAED7089@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506412BC2AB188D44EA981BCE089@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB1506412BC2AB188D44EA981BCE089@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=464ecde1-0565-4b1b-9de4-468a9f34be83;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-20T02:28:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5aff6d91-a57b-4ef1-119f-08d93808873f
x-ms-traffictypediagnostic: MW2PR2101MB1034:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10340F7373CE366A116A3D17D7069@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qbfmotD9MEJpYzy85mrrHQKQcYgxJbHAz5a+d9y91uNhsn9aD1e2YsYqUTCAFCg92GB3ED3A1yNwtJIGiGlAfr/ymJVILsOhAPt51FQbxcDO/hrCnYbxGzv0enrbytgnziF9Z1oSv2/9Sn8thZ/a8B0m4x9y8OSqOzzy0J8vUn1bkUSS9b4kPBbGgf0C1hJXyuiTnKoJRO+SXxZIkbvQrR8r7iGltgnpNcph7jJeMhJq24L9vv4/yUowHtGpjJ5xUKz8UFOHktaMZZVmPBZeuJk1/0QZQ1EhcmrNzx2Hm6s4/wHi5CVzrgGQV8WxSS042GaPAsrxflmy8F3C8dkGJJ1xMp5bezK1HaLWdFv4u5I44sb0uC2CAoV6yNIWomtjQBTDs6ESvEl4JGpPplHI1JyBsTTFxTAE/DjFX17HuFNml+ugRsfJ3/8bnSm1KPHo42Ng2fsl06i5bz597aEjb6/CZ/WFzsaj1lRzaLi0cpfuER7PJ+QjmVL7OX00sgPi5EWpdVwuVTPZ0G7uuoMxf0yk8l6HgmVACSSYYYENFsU32APgFPBT1uzeklgiGiKftSMGY+4yygQpw2ggv8TCEaxEbbm01lyiA0KfQZW6/sk5el9dXse2JzsUiALuuf2GJLfIMKCa4H8gqXiSeWFp1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(478600001)(122000001)(38100700002)(6506007)(186003)(66446008)(83380400001)(64756008)(55016002)(4326008)(316002)(9686003)(8676002)(54906003)(71200400001)(26005)(8990500004)(110136005)(107886003)(52536014)(10290500003)(82950400001)(76116006)(66946007)(66476007)(66556008)(33656002)(86362001)(5660300002)(82960400001)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a2GzuUazBJHfbbmwyLId08qrIEeI0z2rRz5msuWUK7kRBbReExKI66EAPGne?=
 =?us-ascii?Q?F2yFbS68t8mO55LlCVVr1O6UDHvOh+k1y8F5XrlOXZ8GaIZvhESvGY3QyJ3r?=
 =?us-ascii?Q?lSV6wvI+psLmrI5nGDZCqkHFuFrshTddHneL55h+gRgoeuDw3S4aGaumEsm7?=
 =?us-ascii?Q?X7yKONWOzHS7F1/f6mFfPVSZyGY18wI5ETTmazLyPcXRyq66nRKOmcM2DmEx?=
 =?us-ascii?Q?jQ2WtnGruwxj9TEvu+7uvanxPUZT0OnzXO5Z43RdtETn3K3XuyOR9WD+rQXz?=
 =?us-ascii?Q?wKMqNODDv/YfEwdNzZD9EQtI4dE6f5IBzOMpRHkGlfH05SOl9ai+Qa9bvn5F?=
 =?us-ascii?Q?BjmWfsPzMQN6tY3vz4sP/6s1qbR4YKJ/G8bWn8XX9uME2nmSyOwKw7JsezWP?=
 =?us-ascii?Q?bfyoT4Do94e3L/cAngYH10+hnwt6Ti1oMzIxzzBW0YANytih0rwSirdIUVcP?=
 =?us-ascii?Q?N/iiagPRd0JZfwdLcothLKo23Ya3Ch8bO1S/XNzXptziwU1QojWynLeulYD2?=
 =?us-ascii?Q?cWBdD243pUtBxNf9GaFs6It2sqhjgjeVUIaO39OdOj/+WbwHAdnVhPv8jTFb?=
 =?us-ascii?Q?fJ8DX0OSmWIqWO2Mh2WP21EevleCKu2fHBq1k28xTVCDNhjXQSVgYyPSGAh0?=
 =?us-ascii?Q?8/tCV8G1BTbAozZHuNxqVh22TGN+MVb5MlJ4j9wG27DfRqnGjeQnx5RpNrJg?=
 =?us-ascii?Q?TW9lVQLVwmVQYxbvRQq+BjoWxqh2Jeox38UnCMGNmkEIOe4Ra+WKyOE981BL?=
 =?us-ascii?Q?ZbUKjvN4mo/LWfP/rs1U5aBCULBeiOqRxM+cDAbPcKxEe8IFa4BcmefCfXy9?=
 =?us-ascii?Q?HGngoCpAMHh0Ru/Djh+YOKCOu3A9ZAI2jEvLpkByKJ8+xUV9EzxIv1y6mi0Y?=
 =?us-ascii?Q?n/Pi0lFhCblCU6gsFPMWKNWJCc3unWYkjBw1smnRogW/IooqucPoH/DXqJXO?=
 =?us-ascii?Q?ZC4LzqzQZE5+6MKpBk+1SrbHFmPdMIJiiM16xquioT9t5zC3YATsuUIPBQKI?=
 =?us-ascii?Q?TC9zOjtevou8+N7ILeEQDLhXvhsvd1uCW6MESxiOCE2FaJRZJMgWRBzitrro?=
 =?us-ascii?Q?MO1iqDz2bf5LDWPupld2lOpMqC9/9cQdkLU5d13njqfKkJcPFZBMPgBc65G2?=
 =?us-ascii?Q?qLqb6FJJpaxYWMlpgSHU/PPkkjBAW2d4EBMa0CawEQTm/3k9021coT4lPurw?=
 =?us-ascii?Q?sKPW97SBV8cUI4EJl3nDcoF9/VPHyUf7EZDYO+pSQEtBwEFTQRqAGu2/6dda?=
 =?us-ascii?Q?kWJrR8pNxiqEK5IVQ+zLRE35P0rg7smIOxQt5/sKhzsot75DKE2JB7C6qGAO?=
 =?us-ascii?Q?a2u5clSreiy4nx4N45ipFSbG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aff6d91-a57b-4ef1-119f-08d93808873f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 18:39:12.8467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tMv/wXBQv32pH1qc+HAkxmsM9bYFLmgKMfIqXUNIaJM1EkwBG8x3RZh0r31eURwrICFe9DY2o11lNNk6kVIthdk3onDJLKd4gRJ9NVgJwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Wednesday, June 23, 2021 3:59 PM

[snip]

> > > > > +
> > > > > +static void xs_fastpath_remove_vmbus(struct hv_device *device) {
> > > > > +	struct xs_fastpath_device *dev =3D hv_get_drvdata(device);
> > > > > +	unsigned long flags;
> > > > > +
> > > > > +	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
> > > > > +	if (!list_empty(&dev->vsp_pending_list)) {
> > > >
> > > > I don't think this can ever happen.  If the device has already been
> > > > removed by xs_fastpath_remove_device(), then we know that the devic=
e
> > > > isn't open in any processes, so there can't be any ioctl's in
> > > > progress that would have entries in the vsp_pending_list.
> > >
> > > The VSC is designed to support asynchronous I/O (while not implemente=
d
> > > in this version), so vsp_pending_list is needed if a user-mode decide=
s
> > > to close the file and not waiting for I/O.
> > >

I was thinking more about the handling of asynchronous I/Os.  As I noted
previously, this function is called after we know that the device isn't
open in any processes.  In fact, a process that previously had the device
open might have terminated.  So it seems problematic to have async I/Os
still pending, since they would have passed guest physical addresses to
Hyper-V.  If the process making the original async I/O request has
terminated, presumably any pinned pages have been unpinned, so
who knows how the memory is now being used in the guest.

With that thinking in mind, it seems like waiting for any pending
asynchronous I/Os needs to be done in xs_fastpath_fop_release, not
here.  The waiting would have to be only for asynchronous I/Os
associated with that particular open of the device.  With that
waiting in place, when the close completes we know that no
memory is pinned for associated asynchronous I/Os, and Hyper-V
doesn't have any PFNs that would be problematic if it later
wrote to them.

Michael

> > > >
> > > > > +		spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > > > > +		xs_fastpath_dbg("wait for vsp_pending_list\n");
> > > > > +		wait_event(dev->wait_vsp,
> > > > > +			list_empty(&dev->vsp_pending_list));
> > > > > +	} else
> > > > > +		spin_unlock_irqrestore(&dev->vsp_pending_lock, flags);
> > > > > +
> > > > > +	/* At this point, no VSC/VSP traffic is possible over vmbus */
> > > > > +	hv_set_drvdata(device, NULL);
> > > > > +	vmbus_close(device->channel);
> > > > > +}
> > > > > +
> > > > > +static int xs_fastpath_probe(struct hv_device *device,
> > > > > +			const struct hv_vmbus_device_id *dev_id) {
> > > > > +	int rc;
> > > > > +
> > > > > +	xs_fastpath_dbg("probing device\n");
> > > > > +
> > > > > +	rc =3D xs_fastpath_connect_to_vsp(device, xs_fastpath_ringbuffe=
r_size);
> > > > > +	if (rc) {
> > > > > +		xs_fastpath_err("error connecting to VSP rc %d\n", rc);
> > > > > +		return rc;
> > > > > +	}
> > > > > +
> > > > > +	// create user-mode client library facing device
> > > > > +	rc =3D xs_fastpath_create_device(&xs_fastpath_dev);
> > > > > +	if (rc) {
> > > > > +		xs_fastpath_remove_vmbus(device);
> > > > > +		return rc;
> > > > > +	}
> > > > > +
> > > > > +	xs_fastpath_dbg("successfully probed device\n");
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int xs_fastpath_remove(struct hv_device *dev) {
> > > > > +	struct xs_fastpath_device *device =3D hv_get_drvdata(dev);
> > > > > +
> > > > > +	device->removing =3D true;
> > > > > +	xs_fastpath_remove_device(device);
> > > > > +	xs_fastpath_remove_vmbus(dev);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static struct hv_driver xs_fastpath_drv =3D {
> > > > > +	.name =3D KBUILD_MODNAME,
> > > > > +	.id_table =3D id_table,
> > > > > +	.probe =3D xs_fastpath_probe,
> > > > > +	.remove =3D xs_fastpath_remove,
> > > > > +	.driver =3D {
> > > > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > > +	},
> > > > > +};
> > > > > +
