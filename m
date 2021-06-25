Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D133B495C
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Jun 2021 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYTxl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Jun 2021 15:53:41 -0400
Received: from mail-oln040093003010.outbound.protection.outlook.com ([40.93.3.10]:29435
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229573AbhFYTxk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Jun 2021 15:53:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0CcPMFS5ELYS4ppMIRCsjLbGVJGzCk6fOFa3KcApepR0fRql5XH/oVEwaEBgLs8WidvTBcSI5AFMz3P5h0+hYShWnlbkAuT3RcQKWG59yBO3W68iH7dx04g6GqlIPnJUyLkskpIcwgocYxU3gRKuWJFb/QKE0EoljJhpgyP8omgxsp9PKFjBpki7lRNtgticezu3N6PCOt44gc+1W/bW03sQCtaYaOnTiKAIV0SfkITxsSsZXxcanX6WGjxT5C8dodnPhy6uxHyXq68aGJ8UNUPsy77hWonBLOSTF4t65n6LsdIq4yLYl3eXjibqHkS+/xEr+Yq+W/mONEKsAXZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVEhw9NRQYWROqhBEYFZotF7y+BxUryxCfyLD4VRqKc=;
 b=FXOafOkki4QBijeA1nAgt4vOv2am16pVRzcj1vXnNpULM7OXtSRt4ghTyJ3/Y+toiJVgiK4CkwG92BNRdNyOdbzQaVNOOlVa7pswG0RqiPD+WnbjCn9hjc9UCu3dp+cfCFl+Y2naUwTCxlhU+aOuqtj7bVxcIlFkgaooC0XyyBy4dQuMHUyszmvJYgiSeI5ckiH2S1YH0hcADWq1DIORJgnLVDxxLNivhQOa00evlosaY2FyWceNN2GCb82HRsmYQB/8l5JSeSzzAD1HAMcL/UJyRG66QxXxTC3faX1CxFVUaAob0y2SuJcounYKsDPg7gQmTjUCBEYEZpiXv9e6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVEhw9NRQYWROqhBEYFZotF7y+BxUryxCfyLD4VRqKc=;
 b=h7/6EdqKrcdvrv4B4Q1TEJufLpUNOv3CScbgoXleWDtOETwAUlaEv4U8I5QMuAOBz9YTbWkNlz13svxC4QVpTF+EQjl1dpggXatNvy6bGUv4EshqWsVAcZJT9SW6s8UxsI4cUoPAr0EdpUp3yWKe1KQcjZx8alGM73bBCCpmTls=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB2069.namprd21.prod.outlook.com (2603:10b6:a03:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.6; Fri, 25 Jun
 2021 19:51:16 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b56b:cd5f:3b00:1c52]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::b56b:cd5f:3b00:1c52%6]) with mapi id 15.20.4287.008; Fri, 25 Jun 2021
 19:51:16 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
Thread-Topic: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
Thread-Index: AQHXXAJKewe2lsBf2kyeTA3xSHDQt6se2UMAgAMjv5CAAEGvgIAAC3wAgALglgCAABPx4A==
Date:   Fri, 25 Jun 2021 19:51:16 +0000
Message-ID: <BY5PR21MB1506E2C6F2FC805CDE80AF9CCE069@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1623114276-11696-1-git-send-email-longli@linuxonhyperv.com>
 <1623114276-11696-3-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB15931C10916D27DB73CA5026D70A9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506187A82B88BBFECB2A884CE089@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB1593A5DE463C2DC61586ACAED7089@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BY5PR21MB1506412BC2AB188D44EA981BCE089@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15938FD090DDD7BBA186EFAAD7069@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15938FD090DDD7BBA186EFAAD7069@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=464ecde1-0565-4b1b-9de4-468a9f34be83;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-20T02:28:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f9f565d-5a7d-40fa-cd37-08d938129888
x-ms-traffictypediagnostic: SJ0PR21MB2069:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR21MB2069A198FEC722F246D3C1DDCE069@SJ0PR21MB2069.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFuWEQyShmm1j79SzFXjpWjmPMoVTFr1PDpZu3sq+TiO2CqK/B1IBXJLM3bp8PAyvgdp8qiFhWojdUzLvPWW8ffL4ClVJMwa9Sku2cHO4wdIAWagrem/68f/QLK+uJ32mCYPiCu2KRC9gmZYu+wPZZT77/Hlz9cHVt7J0g2urwNrH168IIz1+rP2WPvxZP5h0Ztdc/Ip1/e536gC2odosRbT/PbwC5MPCPO6t9y2MTtZTX7N9vg2MZhRpst9X5H/xfvFl9DpcItvnpgg/jHmq2j4bWQsS+b/kWHkzAs6rx2dIEKlM7BFSxpEtzpcFwRoxyvGl8tFMipsWPJxUaRFXd0kDNRaWnHJ06vlHyD8/g+VQcwxWBp6hwT83I5er+lZ3GzrYrBJRyYOaSPoxv2mRwIwbzsnvpuyrfrl2JO3s9rTm9Sx+cKvWLITM7eY/rVrZiKQ6h4Wis9OTpF2SVnSaOD0gBdnqFqRxXg/yj6hg5qO3+Zb6IQfT7RrXCdUpDBhwNPX9We/pSxKDhueh0lcBtIPtYExTbR9rlUIAafYrPO5gz7iby1jpYrOPr5djpS4RA4XT9XAtToOzroYlnUurbVl6c8B93CFJv4ppPNINZXke+H9C7oTXApg6QACqYWjltinLvtr1JRItuTxKuE8kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(55016002)(64756008)(66446008)(8676002)(86362001)(66556008)(8990500004)(66946007)(5660300002)(4326008)(54906003)(82960400001)(7696005)(10290500003)(316002)(82950400001)(478600001)(76116006)(26005)(107886003)(122000001)(110136005)(38100700002)(8936002)(9686003)(71200400001)(66476007)(83380400001)(33656002)(2906002)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nSgRS79P/x9V9aEKVrSsFJQ+qQOi0mzyjW87jFncdqQ26WT8FDUFxBHV/RAS?=
 =?us-ascii?Q?m24vbS+nmFtdSUGSPkMQOUkk1IzF98XLCV3WfyP1aCHmIBOvusDpTOQl1tik?=
 =?us-ascii?Q?GzvSGHoUVsPeAnvYDePX/Di9JHvrqtuw3dYpcJFbL+If1CMG8r+FnImIwPbs?=
 =?us-ascii?Q?SNSL3FM+4VaDgcL/1JcAjFNSqJ+Qt/ut3BWdFyfTZGF4RnWYiGMW1wnoQ/yV?=
 =?us-ascii?Q?+BkwlpmlrXNzYWZ7jjdK0gFuNJsbCDNDcV4JcY1sSCchwOA07Qd6VstKkeyZ?=
 =?us-ascii?Q?GfmVYoVpSVniAbeCYhuTPmLX19KOlEULEgUsP2yELiKK+67XztkmZAUd2dbz?=
 =?us-ascii?Q?UsduDAusosJFSsqMZsyU86+JNvlKBf15rmz0hEai9TqLs9DKEr0oRxFW2o5T?=
 =?us-ascii?Q?VlSqFa2hQfX3w+vGN+cQjpKQLOg0VXfKyNiK4RiKOgQnNbXcamCPW76DKQhM?=
 =?us-ascii?Q?qu9t25ngNG7D/kyJotdgelv9NIDP9qscA+U0awqWdd4simKUrA2/y+31lBGs?=
 =?us-ascii?Q?DcI8vwPrbYP5q0JVEK+KXz0ls3k8wrsmksg63aHIAAxZDqZapaQt26eEvx/A?=
 =?us-ascii?Q?O9HK/JdtrwIdNCP04hm+MGDcv737oXEYsUaSFzTbwdSexXmBhAX/hlxYiJCp?=
 =?us-ascii?Q?19CWORQzyX2OgwpRFnN/It5F6HU0lN3BesraHUGYoA55VlEYUjplfbxVD0NA?=
 =?us-ascii?Q?ahTTdEp+55sXFbbvBa3xBjuU0Q1f9Oh1069JjudsshJ9tARXM5e9cV8zEsyi?=
 =?us-ascii?Q?KfTjADnGWW5WeRwHtedQvEZiTg3b8DxoqnzqwY8gkVm0nvzgaWg8L/bkifE7?=
 =?us-ascii?Q?Vjeqy3jzRaEjHXDYoYyEjpypid1Ml5aaBpISzHujF7xianrdRuRTYnt2ngfM?=
 =?us-ascii?Q?G7paCTmj0bm57tBizaqFFPnv9QmrGdu5AUuu+U0EeQiDJ6MbeiKBuWv5skYQ?=
 =?us-ascii?Q?BfJZOfx7SMc3ugwUjn6r/ISrSyUsh5SEiqmVJjhuISVhjmW5AkN7IziorBn3?=
 =?us-ascii?Q?rMuAft/IpKKwLwX8xfGZ0pFavuZD3uK/MMhZDqWq6QwtVKDywVjrBargJM6L?=
 =?us-ascii?Q?fTRmyDw7U15ovNzbtuj8OKHBBAsOqWogwG6hjCKio0gh2qXli1men1fdITnN?=
 =?us-ascii?Q?hYSRMNlK+Xj1ynCSYGO7u0RLoTuQyUWXLbp7nffYJa7E/0Mc3cvxawkfTng7?=
 =?us-ascii?Q?+e1S43cFEzKr5EweEdZGkBGcoHVlyDI8/KrT8aoltHMX4EkxuIELRBXtDS63?=
 =?us-ascii?Q?xKLk0P/rk0jlFC0VuKucbQkbjz+tNUemYJcXI19KuBlILYVm2HToli6sGwSu?=
 =?us-ascii?Q?BdTCybxPH1hSmq8jM2qa6NAc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9f565d-5a7d-40fa-cd37-08d938129888
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 19:51:16.6785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9cLkFmuDZHsYnjpilzmCgqTvmWwSfvQUq23bv/WQcTVL5Cg9HD9/lgkzubkO/pKhc3aOdp/ij2I05BktN0OVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB2069
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [PATCH 2/2] Drivers: hv: add XStore Fastpath driver
>=20
> From: Long Li <longli@microsoft.com> Sent: Wednesday, June 23, 2021 3:59
> PM
>=20
> [snip]
>=20
> > > > > > +
> > > > > > +static void xs_fastpath_remove_vmbus(struct hv_device *device)=
 {
> > > > > > +	struct xs_fastpath_device *dev =3D hv_get_drvdata(device);
> > > > > > +	unsigned long flags;
> > > > > > +
> > > > > > +	spin_lock_irqsave(&dev->vsp_pending_lock, flags);
> > > > > > +	if (!list_empty(&dev->vsp_pending_list)) {
> > > > >
> > > > > I don't think this can ever happen.  If the device has already
> > > > > been removed by xs_fastpath_remove_device(), then we know that
> > > > > the device isn't open in any processes, so there can't be any
> > > > > ioctl's in progress that would have entries in the vsp_pending_li=
st.
> > > >
> > > > The VSC is designed to support asynchronous I/O (while not
> > > > implemented in this version), so vsp_pending_list is needed if a
> > > > user-mode decides to close the file and not waiting for I/O.
> > > >
>=20
> I was thinking more about the handling of asynchronous I/Os.  As I noted
> previously, this function is called after we know that the device isn't o=
pen in
> any processes.  In fact, a process that previously had the device open mi=
ght
> have terminated.  So it seems problematic to have async I/Os still pendin=
g,
> since they would have passed guest physical addresses to Hyper-V.  If the
> process making the original async I/O request has terminated, presumably =
any
> pinned pages have been unpinned, so who knows how the memory is now
> being used in the guest.
>=20
> With that thinking in mind, it seems like waiting for any pending asynchr=
onous
> I/Os needs to be done in xs_fastpath_fop_release, not here.  The waiting
> would have to be only for asynchronous I/Os associated with that particul=
ar
> open of the device.  With that waiting in place, when the close completes=
 we
> know that no memory is pinned for associated asynchronous I/Os, and Hyper=
-
> V doesn't have any PFNs that would be problematic if it later wrote to th=
em.
>=20
> Michael

I'm making changes in v2 as you suggested.

Long

>=20
> > > > >
> > > > > > +		spin_unlock_irqrestore(&dev->vsp_pending_lock,
> flags);
> > > > > > +		xs_fastpath_dbg("wait for vsp_pending_list\n");
> > > > > > +		wait_event(dev->wait_vsp,
> > > > > > +			list_empty(&dev->vsp_pending_list));
> > > > > > +	} else
> > > > > > +		spin_unlock_irqrestore(&dev->vsp_pending_lock,
> flags);
> > > > > > +
> > > > > > +	/* At this point, no VSC/VSP traffic is possible over vmbus *=
/
> > > > > > +	hv_set_drvdata(device, NULL);
> > > > > > +	vmbus_close(device->channel); }
> > > > > > +
> > > > > > +static int xs_fastpath_probe(struct hv_device *device,
> > > > > > +			const struct hv_vmbus_device_id *dev_id) {
> > > > > > +	int rc;
> > > > > > +
> > > > > > +	xs_fastpath_dbg("probing device\n");
> > > > > > +
> > > > > > +	rc =3D xs_fastpath_connect_to_vsp(device,
> xs_fastpath_ringbuffer_size);
> > > > > > +	if (rc) {
> > > > > > +		xs_fastpath_err("error connecting to VSP rc %d\n",
> rc);
> > > > > > +		return rc;
> > > > > > +	}
> > > > > > +
> > > > > > +	// create user-mode client library facing device
> > > > > > +	rc =3D xs_fastpath_create_device(&xs_fastpath_dev);
> > > > > > +	if (rc) {
> > > > > > +		xs_fastpath_remove_vmbus(device);
> > > > > > +		return rc;
> > > > > > +	}
> > > > > > +
> > > > > > +	xs_fastpath_dbg("successfully probed device\n");
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int xs_fastpath_remove(struct hv_device *dev) {
> > > > > > +	struct xs_fastpath_device *device =3D hv_get_drvdata(dev);
> > > > > > +
> > > > > > +	device->removing =3D true;
> > > > > > +	xs_fastpath_remove_device(device);
> > > > > > +	xs_fastpath_remove_vmbus(dev);
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static struct hv_driver xs_fastpath_drv =3D {
> > > > > > +	.name =3D KBUILD_MODNAME,
> > > > > > +	.id_table =3D id_table,
> > > > > > +	.probe =3D xs_fastpath_probe,
> > > > > > +	.remove =3D xs_fastpath_remove,
> > > > > > +	.driver =3D {
> > > > > > +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> > > > > > +	},
> > > > > > +};
> > > > > > +
