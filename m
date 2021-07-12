Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609603C4271
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Jul 2021 05:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhGLEBc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Jul 2021 00:01:32 -0400
Received: from mail-bn8nam12on2090.outbound.protection.outlook.com ([40.107.237.90]:48096
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229464AbhGLEBb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Jul 2021 00:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvJcu+L/vYjslTSupQyF8Jx91d4s9UAz5zbghm6wkHgtmqDosYocqum+xSZSPcd4ZMOuQzucX20B3Qpfwlnn6l4AQqq/9bByyHaRIyiUaxwcNkESGBeT62sbhSAEOeAeuzEK7ItuACkNxH1FHtgUL5LamEHXjeLyqBcDvUvIVklxSVMEFuUKDYIH8Bdgb1cWSjuqXaT/bkTC/E0Kvgtj81KvSX33eXtB/TTOh3neKd7TtWPzfA1fn0T/qMZ1VbZeajdeblJhKlD2ef4HLV+c2XU+Z46b+OKBdGVoL8icaIv+K8OZD76mksrwJM7SVV9aa7HSNUHuYwVsCp3LyDuxuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfrAiRVONum8i5O/yH/spBQm6Rhrrd/UaTHOXI5fYEM=;
 b=djVoYBzcv2XdTEnaoNIsiTQPvCCbuUTm7lMfn2ynw4K7X46J3OeE+Nvsi2VFfbx2M5ppqWrHeI5bss5jIv12v6TkV314L0uM8Mn10HvSFjSsZDlCVMge8I1wVH8a5vR2XDqRUwcHZ0BRPrYAysd2KNwa+gDUWqGbtcVm7cBqhF0QcOc0f5+UPj/66eoykjtInqUbyzjgwTl5GVh88v78ohXBGVX0aj4S9HIOoS0jbuKpuaXlnuN1uyezd8GHwbQMajpHT2+NQTYKSw887DK1Hx0XdFDGYe2JM6vHh6sv7PfQfL+Jh87wTzWbLWkgbZDcPlz7UAV6rBUMaPEqViZeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfrAiRVONum8i5O/yH/spBQm6Rhrrd/UaTHOXI5fYEM=;
 b=RezYALT1NOXHqzrhXtZehGaKc0zJdReZV8O/UeBqBAQT40VVy64o1Oe3zo0kdmONzi+N1RHZCp0PcOKvE4s9dXaDrk02X/a/tcfNZ5VGNzRL+QRVz9dEcqmeJj7W+ZnbTGW7WS8hyQA0Z83dgm8F64qbt+ykD48rLajzWQmfyd4=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (10.167.236.11) by
 MW2PR2101MB1817.namprd21.prod.outlook.com (52.132.150.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.5; Mon, 12 Jul 2021 03:58:32 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cdf4:efd:7237:3c19%7]) with mapi id 15.20.4331.009; Mon, 12 Jul 2021
 03:58:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXalTRwSwb8zgU/UyKv3LljLGzrasphsOQgAQvmICAAJcUUIACGm+AgAmQCRCAASj/AIADrOtA
Date:   Mon, 12 Jul 2021 03:58:32 +0000
Message-ID: <MWHPR21MB159321330ED9242231D30F93D7159@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB159375586D810EC5DCB66AF0D7039@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506ACF89447B492B0F7E066CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15939CFE85138C6B73E575F2D7009@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506C29FA7FB4588E3A2BB5ECE1F9@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593F080DF28E10FF6E3A529D7189@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB15060921F762175FB4E85F26CE189@BY5PR21MB1506.namprd21.prod.outlook.com>
In-Reply-To: <BY5PR21MB15060921F762175FB4E85F26CE189@BY5PR21MB1506.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=34b74f3b-f78a-4066-9c87-8e11622defa7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-28T14:56:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcb42470-5f45-4790-0dde-08d944e95108
x-ms-traffictypediagnostic: MW2PR2101MB1817:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB18173EC184B97F6D7CA08506D7159@MW2PR2101MB1817.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S1/lG3nEHvWd05oOGeZMVYoLYtkcL7ApSPtWeBN+LA3pDt93Tf5EY349JwavveZT0RKc2/2e6af8XtHE+Z9XMyCgXYB7Ki2mr257ptEULP2bfBQske8vIVUN0r4eA6PTFiyS+mR0JBuB1W35Cd5uZfCyiiw3aW8U7/Y1SKh9Ud1TRSO1P0L5vGzL80s2fHkLHZ4SeR3ynl8RoZJaJETNlzC0S7jKamgdK8FQE5U1ITTA5Y3orb8YWRPbGzzenb1U2t+eKAHc5Tx/PNLh9xu8dIVsjHoDDLWQeR/vhFclPjpL1pA21ZRYEzq5h/1RoW2f45PAOoo6MaH6jjf0O8m6GLFx08baf5LUM96NL9cy5VL2BhEIg6rQLdCMtNU8Y6FM9dqK8btY4o/EtuH3w9NzHQdTtA4L7BbQM7tkgjtwaMwYln3aly1fk68572wKDqbNRrDil3mCNklyEKTQMZBS7jVpj8uT9axKixEA1ab7RYLcMtNSDH0apgmADodC0Mu2AozMcCxs2VBO1JMIu3J47TYd5bvecNL/c96pG1AZ2Rhd2hR+Th7pbzq9wxHrFxTUoN8KPAsHQVNp6ddbmtjNbkkQsQYjuTOxBJiowR+WXLJvhLaC0wotpJBvY15a/Z851ZHfzwjB95YciOdyXLKedw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66476007)(66556008)(82950400001)(82960400001)(316002)(6506007)(66946007)(4326008)(110136005)(83380400001)(64756008)(66446008)(122000001)(8676002)(71200400001)(52536014)(33656002)(186003)(2906002)(9686003)(38100700002)(478600001)(8936002)(8990500004)(30864003)(86362001)(55016002)(54906003)(10290500003)(7416002)(7696005)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PObTp6EcbxIhKSG4CnqSq4ANcigQOumUbBA8iKCBcekyZbX48mL4ramGKsUy?=
 =?us-ascii?Q?c39YonkjLDdtlPsCqBJyoMbQuyolW7kRTPKqLuk8tDrpd7XAX4drXWtJIfgF?=
 =?us-ascii?Q?HypEDUr5GJph0Oj+4P9PPQOWYFP4hCkNF10IFFpVzBPYbdRxp/UDd+IGQ6xi?=
 =?us-ascii?Q?g+Te71V+JwSpVOMb4B9acbf/X0R8q7uCSWcXcWBYUcrGWdDdyvwFWXbVvRJd?=
 =?us-ascii?Q?by4U9tXyEfz5LhgdxmbFDoIpr4xI/5UaFT3Q4/kFiKzw74DSn5JztFPhj7yk?=
 =?us-ascii?Q?6PuELDFIAwCOZO9Il3bWIgivnw+tUuu3RSoV0+Ok2uzWX4npL2CQHPRU1KYM?=
 =?us-ascii?Q?XMROSZN0kfEiTMpe4KUAkhQFAkA+HJbSzYHNY+MhbNFRi9OUpY4fn5FVogNh?=
 =?us-ascii?Q?z15+usas8Oqa2nyNd5fw9VqF2TaGC310iczOndLdyK9NRbWIJQBA+tnYG3SC?=
 =?us-ascii?Q?Cwa7OgB5D6Ep/oFIw4sPOLa5G7aKKhkceWHgI2BKdmPE8tRTduxCpkfY4Ykx?=
 =?us-ascii?Q?/Z6togUFpgWtzDdyHSb9FA2W/sKGaIw2J5C58TIHFZW6Gdn17VhdpjNk37yY?=
 =?us-ascii?Q?ULfRg/p7Xjcg2SSj2HTg/f7fJd7sCkq5M1dYwVCCgrR4nLgdKRedGvyDilmn?=
 =?us-ascii?Q?EE4ZOYHXSVXOkUt5jyWNwwWGYS4aQXX7wvTFzRvNkz1fJJ4Qr2e4XOT9v4UJ?=
 =?us-ascii?Q?yEW8OLYxX5vqThRNBBNYIwNX+Ws3pb8PXxQAAEFntCmbExvtLVkZua5Dl/2+?=
 =?us-ascii?Q?xe3IhMRwqgzj9ij3WgFJa8TmdYiyTIpE7Bm9QZqIDqWo5+FCn7eHY188gSOY?=
 =?us-ascii?Q?mELTee6OfSACs+VM6hWw3qZhoANWzLZRCbn7LNZFdZblIV0rSBhNnysowzAt?=
 =?us-ascii?Q?iKI4WuSjVhVTymRlx7ZQZlpGyuTiMEA6qyifGT3msvOMCdB7CIaoM1EJHdC3?=
 =?us-ascii?Q?TeRXCUCc4JHBMsWjR8+VT3MQO79ZTPviW0LTCpBPt4vC1SdaFGHASOkV23Rr?=
 =?us-ascii?Q?jOQaQZ5e6XgJm2qM4QUjmbzc7f8NF7txcBfK88oGwFXw0tXIZPFPq2Edp3pF?=
 =?us-ascii?Q?pZatRjvytlnEGxJbIHzfyO6CE+qIONyaVTlUEbmxYqk29ej4ExANJItQABza?=
 =?us-ascii?Q?SoCutUiWTeFL3ek/zid2f+pNeonzluU77dfaZpxse9jaBHCWDuWKDUAp9cS0?=
 =?us-ascii?Q?s4jSsoPsJqY9hXiFw4c5JCBKeh0DvEhMFhI3aJCVKd9+tndw3jxMhXQIp/3V?=
 =?us-ascii?Q?bDYQ863iQalz9XLizrMwRWVwOeAKMEKMVLCfW9OaNqbzafvlChhTZncaKMsR?=
 =?us-ascii?Q?lr2uiC5d1FCm5Hkt4A3CdOMS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb42470-5f45-4790-0dde-08d944e95108
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 03:58:32.4238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqY7aC2wa4nS2GgpOnmxdNuu1wSQlvY5t5PJCzz80jdLYf27j/Bw0OQ+FKFoYxRjUP/EmMFsa/zjjlX7zAgSgEsOuaOxLVq/LYOvN3+8WGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1817
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com> Sent: Friday, July 9, 2021 12:44 PM
> >
> > From: Long Li <longli@microsoft.com> Sent: Friday, July 2, 2021 4:59 PM
> > > > PM
> > > >
> > > > [snip]
> > > >
> > > > > > > +static void az_blob_remove_device(struct az_blob_device *dev=
) {
> > > > > > > +	wait_event(dev->file_wait, list_empty(&dev->file_list));
> > > > > > > +	misc_deregister(&az_blob_misc_device);
> > > > > > > +#ifdef CONFIG_DEBUG_FS
> > > > > > > +	debugfs_remove_recursive(az_blob_debugfs_root);
> > > > > > > +#endif
> > > > > > > +	/* At this point, we won't get any requests from user-mode
> > > > > > > +*/ }
> > > > > > > +
> > > > > > > +static int az_blob_create_device(struct az_blob_device *dev)=
 {
> > > > > > > +	int rc;
> > > > > > > +	struct dentry *d;
> > > > > > > +
> > > > > > > +	rc =3D misc_register(&az_blob_misc_device);
> > > > > > > +	if (rc) {
> > > > > > > +		az_blob_err("misc_register failed rc %d\n", rc);
> > > > > > > +		return rc;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +#ifdef CONFIG_DEBUG_FS
> > > > > > > +	az_blob_debugfs_root =3D debugfs_create_dir("az_blob",
> > NULL);
> > > > > > > +	if (!IS_ERR_OR_NULL(az_blob_debugfs_root)) {
> > > > > > > +		d =3D debugfs_create_file("pending_requests", 0400,
> > > > > > > +			az_blob_debugfs_root, NULL,
> > > > > > > +			&az_blob_debugfs_fops);
> > > > > > > +		if (IS_ERR_OR_NULL(d)) {
> > > > > > > +			az_blob_warn("failed to create debugfs
> > file\n");
> > > > > > > +
> > 	debugfs_remove_recursive(az_blob_debugfs_root);
> > > > > > > +			az_blob_debugfs_root =3D NULL;
> > > > > > > +		}
> > > > > > > +	} else
> > > > > > > +		az_blob_warn("failed to create debugfs root\n");
> > #endif
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int az_blob_connect_to_vsp(struct hv_device *device,
> > > > > > > +u32
> > > > > > > +ring_size) {
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	spin_lock_init(&az_blob_dev.file_lock);
> > > > > >
> > > > > > I'd argue that the spin lock should not be re-initialized here.
> > > > > > Here's the sequence where things go wrong:
> > > > > >
> > > > > > 1) The driver is unbound, so az_blob_remove() is called.
> > > > > > 2) az_blob_remove() sets the "removing" flag to true, and calls
> > > > > > az_blob_remove_device().
> > > > > > 3) az_blob_remove_device() waits for the file_list to become em=
pty.
> > > > > > 4) After the file_list becomes empty, but before
> > > > > > misc_deregister() is called, a separate thread opens the device=
 again.
> > > > > > 5) In the separate thread, az_blob_fop_open() obtains the
> > > > > > file_lock spin
> > > > lock.
> > > > > > 6) Before az_blob_fop_open() releases the spin lock,
> > > > > > az_blob_remove_device() completes, along with az_blob_remove().
> > > > > > 7) Then the device gets rebound, and az_blob_connect_to_vsp()
> > > > > > gets called, all while az_blob_fop_open() still holds the spin
> > > > > > lock.  So the spin lock get re- initialized while it is held.
> > > > > >
> > > > > > This is admittedly a far-fetched scenario, but stranger things
> > > > > > have happened. :-)  The issue is that you are counting on the
> > > > > > az_blob_dev structure to persist and have a valid file_lock,
> > > > > > even while the device is unbound.  So any initialization should
> > > > > > only happen in
> > > > az_blob_drv_init().
> > > > >
> > > > > I'm not sure if az_blob_probe() and az_blob_remove() can be calle=
d
> > > > > at the same time, as az_blob_remove_vmbus() is called the last in
> > > > az_blob_remove().
> > > > > Is it possible for vmbus asking the driver to probe a new channel
> > > > > before the old channel is closed? I expect the vmbus provide
> > > > > guarantee that those calls are made in sequence.
> > > >
> > > > In my scenario above, az_blob_remove_vmbus() and az_blob_remove()
> > > > run to completion in Step #6, all while some other thread is still
> > > > in the middle of an
> > > > open() call and holding the file_lock spin lock.  Then in Step #7
> > > > az_blob_probe() runs.  So az_blob_remove() and az_blob_probe()
> > > > execute sequentially, not at the same time.
> > > >
> > > > Michael
> > >
> > > I think it's a valid scenario.  The return value of
> > > devtmpfs_delete_node() is not checked in misc_deregister(). It decrea=
ses
> > the refcount on inodes but it's not guaranteed that someone else is sti=
ll using
> > it (in the middle of opening a file).
> > >
> > > However, this works fine for "rmmod" that causes device to be removed=
.
> > > Before file is opened the refcount on the module is increased so it c=
an't be
> > removed when file is being opened. The scenario you described can't
> > happen.
> > >
> > > But during VMBUS rescind, it can happen. It's possible that the drive=
r
> > > is using the spinlock that has been re-initialized, when the next VMB=
US
> > offer on the same channel comes before all the attempting open file cal=
ls
> > exit.
> >
> > I was thinking about the rescind scenario.  vmbus_onoffer_rescind() wil=
l run
> > on the global workqueue.  If it eventually calls az_blob_remove() and t=
hen
> > az_blob_remove_device(), it will wait until the file_list is empty, whi=
ch
> > essentially means waiting until user space processes decide to close th=
e
> > instances they have open.  This seems like a problem that could block t=
he
> > global workqueue for a long time and
> > thereby hang the kernel.   Is my reasoning valid?  If so, I haven't
> > thought about what the solution might be.  It seems like we do need to =
wait
> > until any in-progress requests to Hyper-V are complete because Hyper-V =
has
> > references to guest physical memory.  But waiting for all open instance=
s to
> > be closed seems to be problematic.
>=20
> My tests showed that misc_deregister() caused all opened files to be rele=
ased if there are no pending I/O waiting in the
> driver.
>=20
> If there are pending I/O, we must wait as the VSP owns the memory of the =
I/O. The correct VSP behavior is to return all the
> pending I/O along with rescind. This is the same to what storvsc does for=
 rescind.

Yes, we have to wait since the VSP owns the memory.  But you make
a good point that the VSP behavior should be to return all the pending
I/Os at roughly the same time as the rescind.

>=20
> It looks to me waiting for opened files after the call to misc_deregister=
(), but before removing the vmbus channel is a safe
> approach.

To me, this would be a great solution.  And it closes the original timing
window I pointed out where some other thread could open the device
after having waited for the file_list to be empty, but before
misc_deregister() is called.  With the order swapped, once the file_list
is empty, there's no way for the device to be opened again.  So it solves
the problem with the spin_lock initialization.

>=20
> If the VSP is behaving correctly, the rescind process should not block fo=
r too long. If we want to deal with a buggy VSP that
> takes forever to release a resource, we want to create a work queue for r=
escind handling.

I don't think we need to deal with a buggy VSP holding memory for
an excessively long time.

Michael

> > >
> > > This is a very rare. I agree things happen that we should make sure t=
he
> > driver can handle this. I'll update the driver.
> > >
> > > Long
> > >
> > > >
> > > > >
> > > > > >
> > > > > > > +	INIT_LIST_HEAD(&az_blob_dev.file_list);
> > > > > > > +	init_waitqueue_head(&az_blob_dev.file_wait);
> > > > > > > +
> > > > > > > +	az_blob_dev.removing =3D false;
> > > > > > > +
> > > > > > > +	az_blob_dev.device =3D device;
> > > > > > > +	device->channel->rqstor_size =3D device_queue_depth;
> > > > > > > +
> > > > > > > +	ret =3D vmbus_open(device->channel, ring_size, ring_size,
> > NULL, 0,
> > > > > > > +			az_blob_on_channel_callback, device-
> > >channel);
> > > > > > > +
> > > > > > > +	if (ret) {
> > > > > > > +		az_blob_err("failed to connect to VSP ret %d\n", ret);
> > > > > > > +		return ret;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	hv_set_drvdata(device, &az_blob_dev);
> > > > > > > +
> > > > > > > +	return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void az_blob_remove_vmbus(struct hv_device *device) {
> > > > > > > +	/* At this point, no VSC/VSP traffic is possible over vmbus=
 */
> > > > > > > +	hv_set_drvdata(device, NULL);
> > > > > > > +	vmbus_close(device->channel); }
> > > > > > > +
> > > > > > > +static int az_blob_probe(struct hv_device *device,
> > > > > > > +			const struct hv_vmbus_device_id *dev_id) {
> > > > > > > +	int rc;
> > > > > > > +
> > > > > > > +	az_blob_dbg("probing device\n");
> > > > > > > +
> > > > > > > +	rc =3D az_blob_connect_to_vsp(device,
> > az_blob_ringbuffer_size);
> > > > > > > +	if (rc) {
> > > > > > > +		az_blob_err("error connecting to VSP rc %d\n", rc);
> > > > > > > +		return rc;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	// create user-mode client library facing device
> > > > > > > +	rc =3D az_blob_create_device(&az_blob_dev);
> > > > > > > +	if (rc) {
> > > > > > > +		az_blob_remove_vmbus(device);
> > > > > > > +		return rc;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	az_blob_dbg("successfully probed device\n");
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int az_blob_remove(struct hv_device *dev) {
> > > > > > > +	struct az_blob_device *device =3D hv_get_drvdata(dev);
> > > > > > > +	unsigned long flags;
> > > > > > > +
> > > > > > > +	spin_lock_irqsave(&device->file_lock, flags);
> > > > > > > +	device->removing =3D true;
> > > > > > > +	spin_unlock_irqrestore(&device->file_lock, flags);
> > > > > > > +
> > > > > > > +	az_blob_remove_device(device);
> > > > > > > +	az_blob_remove_vmbus(dev);
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static struct hv_driver az_blob_drv =3D {
> > > > > > > +	.name =3D KBUILD_MODNAME,
> > > > > > > +	.id_table =3D id_table,
> > > > > > > +	.probe =3D az_blob_probe,
> > > > > > > +	.remove =3D az_blob_remove,
> > > > > > > +	.driver =3D {
> > > > > > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > > > > +	},
> > > > > > > +};
> > > > > > > +
> > > > > > > +static int __init az_blob_drv_init(void) {
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	ret =3D vmbus_driver_register(&az_blob_drv);
> > > > > > > +	return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void __exit az_blob_drv_exit(void) {
> > > > > > > +	vmbus_driver_unregister(&az_blob_drv);
> > > > > > > +}
