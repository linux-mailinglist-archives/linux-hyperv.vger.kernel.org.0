Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336606025E1
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Oct 2022 09:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJRHg7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Oct 2022 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJRHg6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Oct 2022 03:36:58 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020024.outbound.protection.outlook.com [52.101.51.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877FBB7D7;
        Tue, 18 Oct 2022 00:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibLupW3pFLoIFBApqK51+ceHdkCkAhSQ4iMGL3GrDlQQnxQp88oeGqaAi+bEPn+6mu0C5eGZT08azhFR3Ax8dKjev3aLPmW8tkWdX+gDt4pjGz9jjkQe9qeq3+O6givFvKUqq/MGGyYnPWUbx132PH6O0A3CwegVkl0QjOD/laQ5BruG/zvR27jBbAHkdFh/YdzJi9RtJfFrQOXNVLbF7aIE4Rx37UXo8P7b7d4iOmKFHyyGZGaZVY3IWRapVO+f01RNV8dUC5PA2/5aoCcC3liqBkO9Qx1SIRGLCVmZ3HfAgHckqbGiefCQT+Id706PJC+LaKhXvq+Pgwl74XenIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eucWA4EyO61eME89nKUK3KsQsrowzpr00RxkNrs7hQ=;
 b=IkNHfYN6dDobhupya5lK3HxdKs8xTI5mUgE5Uti2/zQEhdWvaBeQBaUE220+IwnW5E3xiQxmXUoEVC4U1EuknCQK3VCwujL0exYHEY9ITBjQkCS4xR82hYl2lXnxseftkG/+jvKJ1IqtEyFc98b51INQRkKqS0hBC+VzaGVseh+OooJCuy0/yT/1L36WfZX0Wf9PVvCHQnhrskwBg7vgmALeQrljP8GByXoeFxDFcgIxsH3BCM6HGq5KPh7CpZmj0Uz3GAOC+wuCAsE2bu1gcokgaTAaK9hn03GIbg4MAIYgGICpbZVV98y4PlLV1XQj7i+92x9FI4xd3/yGOqjOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eucWA4EyO61eME89nKUK3KsQsrowzpr00RxkNrs7hQ=;
 b=BvLlcnouh0U0Iko6KukjqI9s2U/s6b4A32QrJGFpc0SwB3x2o5NvpVxobIZhR1Kuu8Ke6GBy6uShFKiZGpKLQh8rI2JNbXaUeYrxXmThFerKeXhW6ojAN5yPTCKM80xTHJgD29QGWgAjq2o/23DTyemuL4QMrDo7HmGNnzvofMs=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SA1PR21MB2052.namprd21.prod.outlook.com (2603:10b6:806:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.11; Tue, 18 Oct
 2022 07:36:55 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7c3c:5968:72d6:3b5f]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::7c3c:5968:72d6:3b5f%7]) with mapi id 15.20.5746.016; Tue, 18 Oct 2022
 07:36:55 +0000
From:   Long Li <longli@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
 devices
Thread-Topic: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
 devices
Thread-Index: AQHY3zG2NgbGNaLQJkmnL/cmXn/Bqq4NgIeAgAYwnHCAAAldAIAAARWggAAF4gCAAAYF0A==
Date:   Tue, 18 Oct 2022 07:36:54 +0000
Message-ID: <PH7PR21MB32635863B075186A70C70727CE289@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com>
 <Y0kRIcXG+wNbcGx0@kroah.com>
 <PH7PR21MB32633D172133A769357BD97ECE289@PH7PR21MB3263.namprd21.prod.outlook.com>
 <Y05KQFQUR5Is3RuC@kroah.com>
 <PH7PR21MB3263ECBE949C7F0858075F3FCE289@PH7PR21MB3263.namprd21.prod.outlook.com>
 <Y05QGBml/sj0ZFAG@kroah.com>
In-Reply-To: <Y05QGBml/sj0ZFAG@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b72a0588-577c-4c28-af09-bda21b7acb86;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-18T07:26:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SA1PR21MB2052:EE_
x-ms-office365-filtering-correlation-id: 8c9e1ed9-e47e-4bb5-9213-08dab0db87d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SVBO0p9K9VYOx6zrAhqvkVX6bSGTdHDuzckAlJJnKrX+HShpUeCEE8vDT8MPavdjJh/uYoRHS2lyDYED4XrMC60LI7YI+i5TMmXK2gCfp8xDIM6GNsMWfsKjWLlMgQ9wBxWwSd4C91E1QBweiD/hrovLffg/Xn4Ve8eonlfhNxcdBMw1+zSVuYQfnBdZU4mn7PXqcovZpvL7PsovxcPff3/HXWsZXq8KORUXm3xpp6/qzdFi29IarOfkEwG4zkbPa8xzE4S1uLxittg4bWTrWwaDmngyVJfqCgWXHRnqWLqaFzlTp6ZAz51Z/JAPwKLKttmk0p2N5H7t7FBlxAlmsPaAC/2rw0t9i3aeaS0wiuydD2M/0joN86DSHNvsJRPNR1yMeGNynxYeRjUA3WGD2lMxmw78kyMBYewl+YPhtzxukp/ztjkUtHOVJobYB+VSCk39kB5X+vPaGm6CwgESCsHB4rcUK52rQQq+EzqOwLhgEFVwfwmN1mALxx0oGlJrwXdi/YAmkK43Z8w1I98ec0J6RDXJREwmhLLWZsnuM/SSX6zZq75MPCpTo9xjVU+i6HgtHDs2p8p6WkOd308NtdXGl7mbh11GMvQ0CdL+4BPM+WdybNyZXJSDK9/ZjhWnF9Ui6JEMKpPydz75XxDL7ySD4a0SQESkLIKQFwqL41/wr04Pqad+y9++Cmz96FQUborWsfuMY55Y38i5ojzJIsPDJcxMERfRYRUsB1dz1snL2VGsiIL4W+8bP95nL/IWWnNkaZpwG9CF+kyZ3e0yxnNfhxXzxuP0kMEBJJktDrgQSGSTTEucWRwYNmGitb6+mj5JE3rcrCGKcOnw33H5Dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(33656002)(55016003)(4326008)(76116006)(66476007)(38070700005)(122000001)(54906003)(66946007)(6916009)(5660300002)(8676002)(64756008)(66446008)(10290500003)(66556008)(26005)(8936002)(38100700002)(82950400001)(82960400001)(86362001)(316002)(107886003)(478600001)(9686003)(7696005)(6506007)(71200400001)(52536014)(8990500004)(2906002)(41300700001)(186003)(83380400001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4snGgoOnN5jbaQOZo7XtSo2QFI1dbE43W50kDDKzA8S16/ANhk2CrlayZfSs?=
 =?us-ascii?Q?3jjPQDe3SFXn+4z6sSP8FKsqpud/QOoB2owuOdGqBoaEf4auNszqJRioddKG?=
 =?us-ascii?Q?HastUV7SoNGSUEvqzMkhR5jrsYIHp6TJlQ5T8oUAu0SAWbsTbMt+ICxKz37L?=
 =?us-ascii?Q?L4xNRenildUlbI4msKiRUHb84WpiDxbZPW7/JIM6PWIqrIZ3gNj5T7eOm5p9?=
 =?us-ascii?Q?XSQzHTeiCExEpkJoXz9hLAupc5BTHhWp7ebD1M1sqq/LwqGiLZHELRGAb5Tv?=
 =?us-ascii?Q?rQHuiwtvHcGgPsDf7zP1lGrzJaL9GrLDy+/FqtDE9iDnarw3jT8P/5tr3uwO?=
 =?us-ascii?Q?205Fu+A6nN78qYlyyX08orAtQqfaaJlvGle/EoGz01UuPFi1EBebjc6TaQVE?=
 =?us-ascii?Q?ObJ1ud/iHuhCDCDgAPjeKFhf+ZWrFexlPXuvw9YNQwn5MVgwQCfGQ0bz8Jqy?=
 =?us-ascii?Q?KaUNHMmz3L+0p6wVEi36mJrY2HM7Wshl15PytbfMNjQc5WSTP31OHXAEHmzY?=
 =?us-ascii?Q?pYmUrYqDQY50VvlhJHI910WrteFtrnTLCtOkYai7QtIJwrNHOU3cpCY/Tm7E?=
 =?us-ascii?Q?9B58MfqiYZYCT8qNsTlSR1X/8tqBAvHMQbvCZVQCOX86eAXkHSm+HAUtkIyo?=
 =?us-ascii?Q?xwQteTAj1ZhUP228AHfng472L+nMnxfU3VIj5XXhpr5e9QSOSBRvTdyG08y0?=
 =?us-ascii?Q?mxVa9W5OH4kVGBFrdlI488v+BLf8KAQ6ZYLTMN0aOmbUsb9uWIhAREg02R2s?=
 =?us-ascii?Q?dwP+X5xaGob6uy3gvsYuyJNOOPuo2whTVKHIhBgsT19Ic6Ppp7d8uwdcpqhA?=
 =?us-ascii?Q?pm8DxIfl5D20C3FsLlB5drrSLkUth8+HMdTQmtg98lVqbNb9pmOX7QejDH9d?=
 =?us-ascii?Q?FQvNDfF5IHM6laxnmyvFb6KA6VQKEK4HhYOwmod6mu56nf3oNgyj5Y6Iey5O?=
 =?us-ascii?Q?VsGqvsZ+2HtxRofJ0TZcZBNY6CVUY+w9SwiM85cklkzkHLBZIpDbD4/yZbVJ?=
 =?us-ascii?Q?TQ0C/WCD2SGTZ9+Bozb4J+hdQRr6q2l4yKzEob+FJ2EmSWA7Lh6tsyFFYcn3?=
 =?us-ascii?Q?0XSGZr/WBscyJVrbgDnV6t099ADU7Zf3PQ02plte6mhUfTr+xHi3t/PXgxcg?=
 =?us-ascii?Q?NntZPWBnXg0IUc/kOE7vWjsfroEiivO7iM6tSg9AH4Qwe/BTnSx6Tc3JfjZW?=
 =?us-ascii?Q?/+00El2ub2pgYA3peBQrmvAaFAKtdjB9zXwybTou602Np47gEuAaYW1Vzklt?=
 =?us-ascii?Q?tGDG1Jtz3RbpCwJn/OpS8zGDGLgaq2uD8FYUlHKFlKK/TDW3AXEqnc0ivcQ8?=
 =?us-ascii?Q?10MCYn12fgB7d1cNnjMzPrIL6GooXmSYztosaB/m9Nl9bSeVEY/aHy3G8qlx?=
 =?us-ascii?Q?c0D6I9dicmVjeM2a0SX128Sat+IxgCNqtG1TWOltB4vBSd+Wusj7mn5T1Q/l?=
 =?us-ascii?Q?nG0kpkG/KloiEPXOPkvgwl2jVpgs7v6viNd8CSW78oA2c2QTUI5JnbFWzSo5?=
 =?us-ascii?Q?Vd1Z6+xjqWQ//LbM3P5AUiIPyMPWpLM72WL3aIpGbM8jz/hJQxcyKEkjYk3O?=
 =?us-ascii?Q?dH0t9XOu/GcYu1z4yzrTLuEvg/hnsRG7jM+dV+fQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9e1ed9-e47e-4bb5-9213-08dab0db87d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 07:36:54.9634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Om2dytjRWuBsFWbWaeRVjLpTa532aYxWraEG19qqeOrsYXKxVyXyfI0Dautf1hD/IR4U6fU6vVC8FmlMRjmtYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2052
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low speed VMBus
> devices
>=20
> On Tue, Oct 18, 2022 at 06:57:33AM +0000, Long Li wrote:
> > > Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low speed
> > > VMBus devices
> > >
> > > On Tue, Oct 18, 2022 at 06:31:16AM +0000, Long Li wrote:
> > > > > Subject: Re: [PATCH] uio_hv_generic: Enable interrupt for low
> > > > > speed VMBus devices
> > > > >
> > > > > On Thu, Oct 13, 2022 at 11:29:14AM -0700, Saurabh Sengar wrote:
> > > > > > Hyper-V is adding some "specialty" synthetic devices.
> > > > >
> > > > > What devices are those specifically?
> > > > >
> > > > > > Instead of writing new kernel-level VMBus drivers for these
> > > > > > devices, the devices will be presented to user space via this
> > > > > > existing Hyper-V generic UIO driver, so that a user space
> > > > > > driver can
> > > handle the device.
> > > > > > Since these new synthetic devices are low speed devices, they
> > > > > > don't support monitor bits and we must use vmbus_setevent() to
> > > > > > enable interrupts from the host.
> > > > >
> > > > > That is not what the UIO interface is for.  Please write real
> > > > > drivers so that they tie into the specific user/kernel apis for
> > > > > those device
> > > types.
> > > > >
> > > > > Without a specific list of what these devices are, I can not
> > > > > recommend that anyone use the UIO api for them as that's
> > > > > probably not
> > > a good idea.
> > > >
> > > > There are some VMBUS drivers currently not implemented in Linux.
> > > > Out of all VMBUS drivers, two use "monitored bits": they are
> > > > network and
> > > storage drivers.
> > > > All the rest VMBUS drivers use hypercall for host notification and
> > > > signal for next interrupt. One example of such driver is to
> > > > collect process level crash information for diagnostic purposes.
> > > >
> > > > Also, we want to move some existing kernel mode VMBUS drivers to
> > > > user-space, such as hv_kvp and hv_filecopy. They don't really fit
> > > > into an existing kernel API, and they create their own devices
> > > > under /dev and communicates with a user-mode daemon to do most of
> > > > the work. It's a better model that we can move those drivers entire=
ly
> into user-mode.
> > >
> > > How are you going to be able to remove drivers that export an
> > > existing user/kernel api and not break current systems?
> >
> > It will be some configuration challenges, but it's doable.
>=20
> How exactly?
>=20
> We can not break userspace when you upgrade a kernel version.
>=20
> > Newer Linux
> > VMs can be configured in a way to use the UIO interfaces. This doesn't
> > break any existing VMs because the old model will continue to work
> > when UIO is not used. Also, this doesn't require any Hyper-V changes.
>=20
> Hyper-v changes are not the issue here :)
>=20
> Again, you have to support the situation where a system upgrades to a new
> kernel and all the same functionality must be there.  How will you do tha=
t if
> you remove drivers from a newer kernel?

Currently there is a hv_kvp_daemon that interacts with the /dev/device=20
created by the hv_kvp kernel driver, this is the only program interacts wit=
h
this device. This program is acting like a user-space driver, in a sense.

With the new kernel, if the KVP kernel mode is not present, this kvp daemon
will not start. All the KVP functionality is handled by the new UIO driver.

>=20
> > > UIO is for mmaped memory regions, like PCI devices, how is this a
> > > valid Hyper-V api at all?
> >
> > Currently uio_hv_generic is used to mmap VMBUS ring buffers to user-
> mode.
> > The primary use case is for DPDK. However, the same mmap model can be
> > used for all other VMBUS devices, as they all use the same ring buffers
> model.
>=20
> Ok, that feels like overkill...
>=20
> You need to also post the source for these new userspace drivers
> somewhere for us to review.  I don't see a link to them in the changelog
> text :(

Yes, we will share the user space VMBUS drivers. What's the concern of crea=
ting
VMBus driver in user-mode? There are many examples of kernel drivers moving=
 to
user-mode. For example, DPDK wants a network driver in user-mode,
SPDK wants a storage driver in user-mode, although they already have corres=
ponding kernel
drivers.

Long
