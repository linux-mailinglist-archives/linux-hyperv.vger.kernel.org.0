Return-Path: <linux-hyperv+bounces-1491-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6A844863
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 21:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5A61F24F53
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC83F8F0;
	Wed, 31 Jan 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VnxBfS3w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022011.outbound.protection.outlook.com [52.101.56.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069913F8E6;
	Wed, 31 Jan 2024 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731546; cv=fail; b=ZmRJrTTs099s65D9RJULFDWRpFiuuzHORSZRYzVKc855zW9yduTXhfssAeeOHKXSJQVOpoJqu4LGTVy4FjjD48XmhBVuYwTFxJnPYIEGx177JD33QBIkcPpBi9j9RR3sBjtxoLi3aU86yuFO846U0e1JXdH766aumhgho4m1MrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731546; c=relaxed/simple;
	bh=4l34O8IysWodp8UFmAeNUIwpRNJUMiU7RjZJJ+W3WJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XzdytncyggfaVGgFIpxWxwOoNFBCR3OZTNohS5rXDCGy7mZDXgNCBtb17p3yRZmhOn8PtV+Rn1v9XbZCl1gK26T5wZ4C2VkVP5dZ/Bt5TnO+xiy3ouNdeWf+33B2kuSES0sV4LJiu1zWBkcayHTlCieeawgBp1Q8Mo69vlz7CA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VnxBfS3w; arc=fail smtp.client-ip=52.101.56.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWGNIU21AX+E1TdCV9ZErMbHvTatOxfU6NMifoeb6AxSY7i/ZwK6jj4a5GQ0h3tC57uZejuRaDAgEv+y20a1LCBrjda3zWiynwtGoUWqlBsJTGzHXmgHGavx7XgcYyOVgT2T4Ida3MHq6RtM2lbxO+xLcum8tsUmTZXG2z0JppZCJGX+PewH95wMpDaZrk3Gn1VEwwgB/m2hNke5NbgO6WNrEJe+ZVt9omx+Pso+zDAhrhLTilV3PUqUTb1TRqYBZdN140S0RlJ/DPxfVAka5FYi1QS7YVCWf6uofN5J8/F0pDyXZOhHNNn1O0/MSHkWSsMeNHoWcF2iakInlkHqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lAVu4As9hIJmi7PhDqPkXNM1ObofFZnvR2SfR72zZs=;
 b=Efet5qf2+TiAYqlcwfTrYNsjd7ZiGqA9ngu6URMqJdDhTbIh+v0OdwQyRhdrFAPvdC/3UJDMM8W4bjyqNxVCpdK5U4FElYWdeMXNJDzzL3fGFRSg1P7U9/12O4fRXSCpbGlY9JT6mcm2aAMz7MrrbD+8jf1Fik+guCLAEx1zf8xrIgWAtWuAFQHts5uxeSXMrJOcMId+oSZCwt140ngyXQ3ejcpaTZdt9zqny3gGleZPjS/Kbr6kRtT1750f2gb7oS7mWSKXsL1sLxIWe/Iu5dUtCQYPrRXiwzewt77sSyz96nmWORmn4loVsImm9VwS9qpDhwna7WMqtuyB/5lg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lAVu4As9hIJmi7PhDqPkXNM1ObofFZnvR2SfR72zZs=;
 b=VnxBfS3wN4quWWxoRv4Y2PDr6mcznf13CjNgXXESjXsiQgPqLciKhlsnC9v3Q0eamfd1O8cShKLXmX/XfTnd9Mu2XgY8h6UNJYvvT5XFXd2MTfW6ySsexvAZg/K+sfEqUnGPwZL5w+fml+PKOMoVL9IRQ/oBswreelrl9BzYDPY=
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 (2603:10b6:2c:400:0:3:0:10) by BY5PR21MB1460.namprd21.prod.outlook.com
 (2603:10b6:a03:21d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.4; Wed, 31 Jan
 2024 20:05:40 +0000
Received: from DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45]) by DS1PEPF00012A5F.namprd21.prod.outlook.com
 ([fe80::ff76:81ea:f8d6:45%8]) with mapi id 15.20.7249.015; Wed, 31 Jan 2024
 20:05:39 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Shradha Gupta <shradhagupta@microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaU0yZNOZ7/lEXVUScWvjgIg8G/LDyyvGAgADDxwCAAI9LcIAAFIAAgAAkwVA=
Date: Wed, 31 Jan 2024 20:05:39 +0000
Message-ID:
 <DS1PEPF00012A5F6DC9FADEC65BDB80AA58CA7C2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
References:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SA1PR21MB1335C5554F769454AAEDE1C8BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20240131075404.GA18190@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <DS1PEPF00012A5FD2F8DBDCA1A0A58C6AC6CA7C2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
 <SA1PR21MB133546A5D3B1E471E4021A00BF7C2@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB133546A5D3B1E471E4021A00BF7C2@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94a4fd25-9eef-4088-8818-4ef9b583d8ec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-31T16:26:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PEPF00012A5F:EE_|BY5PR21MB1460:EE_
x-ms-office365-filtering-correlation-id: 293bdc4d-fccb-4259-302e-08dc2297ff30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 M6k9MKYOMdQqjo8F+eEsHP3H9XhhyisQai1ySIlccbK8FSG70CAe9MeFAyqPPhuDEdlPGbG4K8LO9LaWLwcdeFs/5LVm1iH8SXIpnRAVYCC8hmZ7rnZuWP2YdA4mrQcjQTYNiLrR7pW5leEeGVOTDUSd5SUWJqk9LvYIn/RXTJOnBC/U8rALD1pGlF99DcMfFYfMlvMCLMwQDWQXSrzCCpkdglqwTXLUXFadmbLr8EdY5AOY0xUUWBDqy3rA6cteuhFrfBLDLiK7yoxoTVWp3/278cOEIyY/lNB3hXHFmdGw3BS1EUzLSfqo19012gLJWaYO1+2rD64HobPuqnrFrXWAB9DyvhijCmoJr0GPaW3gNhLt9Fh7YiLyQ5VmV01EWzfItKAxZYg3S1rtGVQ4gPpzreZo0qJmvMFBcplk1qJwSG2NKqGbgunQE1TQ8tgnbr8y9F3Pp5HXdysZzdroYHEYnjZgYvLrVv6zTl7jTFVF3NOa88P1JINbKCac/nSYlkHaUov71Aw7XuiDTl4wo1j7UzeBf1Lw37go8lIoYZ9yqmPZebnx+k9VHYR1yMAw1G2qmweUtlcukELdHohP50ndfDWQ1tUSyHA5dB+xidrMezfQjTLkcKOq8LaonB+D
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PEPF00012A5F.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(41300700001)(55016003)(7696005)(478600001)(82960400001)(71200400001)(10290500003)(38070700009)(83380400001)(6506007)(9686003)(53546011)(316002)(54906003)(82950400001)(38100700002)(122000001)(64756008)(66476007)(2906002)(86362001)(110136005)(76116006)(7416002)(8676002)(33656002)(8936002)(66946007)(52536014)(8990500004)(66446008)(4326008)(66556008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZoY9wf5ImRgsM6ZhlAtBGq3n1bM1cZEA5kqWVghSQr/JRO4HNU9XpbEMbPAi?=
 =?us-ascii?Q?F1YAg+o22LupKvXx0F4fa+3pd7QeQPeW3Wt413a5pLkLXkQKcTV9X/STaUTM?=
 =?us-ascii?Q?zR4TI+R50HSgi+eU0d+YA5xka8gn9j8tVOl5G8nZ6Gr+1gkGe1MkqS+p0l44?=
 =?us-ascii?Q?0OikkPXqzoM9yDWXQAPEKgpg4bTOsudcxVMP6s/L7VQc2O/aCmFxXdQ/bt6h?=
 =?us-ascii?Q?REO94ox7+Q6vLNsLDM0vcxQtY5BzUuKn8LqKFtni2niCnkX0yA3Iib+oVSPI?=
 =?us-ascii?Q?THqa2RZz3A/3RdCbjr9z6sGLl8vKulAAtFyrBPBWfHd5vzoJqYfk1Cj54oRs?=
 =?us-ascii?Q?7pjzN0nUwmNdWrJkbzI2zQz/FcoiMwDr90m50Z7FP+iPdVbNBG1XmBTdGchQ?=
 =?us-ascii?Q?3i+Ul1mIw0W4bGDKVIyhvVfaGP3p5bW6B/4UocxJFkGCo2qc0RQnZunaGFCZ?=
 =?us-ascii?Q?qBVneD8CGHPZYN8l3tQNasMgXXsP8XactcS/S9yb15yztfPg2Rv++Wv8m3Dp?=
 =?us-ascii?Q?frdI8+CRmXv9i8e+YMxHvqRSAdXSZcynkOz6cNIIqaThO22uKffE2hSV1Whu?=
 =?us-ascii?Q?B9KFUOvIn6eqBKpkjdlVNMY9KVhpjxV+t4ItMq4LwWWVomNDHeXhG+rMFqcO?=
 =?us-ascii?Q?jZg+Eyfgg5yL6LYBNxQXejAH7LXZ6G/0nafDYvm3ZwkD4P8g6BzjkwVYuqSN?=
 =?us-ascii?Q?ZSA4ysVFf3po5xMjj0NWTuEkhMwOQk24sVHWHHYUB6xvujjLNEHIn8+YKg3b?=
 =?us-ascii?Q?JHtAKW5lTTXHduGifdGOvHPXys9Wb/bYm2ZLwh7lHejrdN5jJQfJh5CiHpOL?=
 =?us-ascii?Q?eFO8DM1mGVDaNOBEet/SVISESIs4tEazwDWLlQIUKl7W+Imd4RGvDj8dX1M7?=
 =?us-ascii?Q?vwcb1/8SsoEJqjV9NC5pBfySmU8xofcNWSUjY7Sg6H6VhLw+pZq+dTnSRpHv?=
 =?us-ascii?Q?Wbx5jxwv01WwPo9DN3mlPD8IHlQuniX7gbl+nByrfFPsV8RujyG/fZWXZXS/?=
 =?us-ascii?Q?GAGrtZnmt+9QpgmQdZzox78UGI98hkla7/0J9IqcZMOkgIa3I04iV0UyBDSD?=
 =?us-ascii?Q?3b8YKg6qavyvVp3sTTPP2bBS8j+3ftOXAJ+/w4sjsNSu33U6PoIspQtVqkqm?=
 =?us-ascii?Q?tZpXOjpBA41xG08qran1+a9/llLEIHhZ4jDjzJGkMpKYIqNNG0jHVqhyocOi?=
 =?us-ascii?Q?oPLYwKp6h8pC/hCZhi2CMDWbqdt+61kler+1Sagh4eT/LBfcG2k3GAeFJEnG?=
 =?us-ascii?Q?4n/8GTWAZ6LTU0rCwONC7Fn+cmkhtUnQ22Pse4hRtQNmIoBIzTQuFxIDiNN/?=
 =?us-ascii?Q?a9HHRDy5X9eXsRvHgsT5VElbOj7Eb9fQPYYvqRyUCxA7qLiSALJpMeykC5yL?=
 =?us-ascii?Q?zjdnpyIkhQD9eEGk9YSi7vtOYMJyGNRXatNob1KUixAXDygkJNZj9zdUPqfP?=
 =?us-ascii?Q?CwZ0k83ZkYfLGvRrdl0ABSuGitAVBl0+6LI7OtpB6XWzUu5s6ydXq9DJJ7Q4?=
 =?us-ascii?Q?y3lZmlwMZI4dKRvjADidy8oakKUOUvl94u3Mgv+sDIHNIxEjm2/ET6DFJx0T?=
 =?us-ascii?Q?OqVdgjW02LA15JaethjISMeN8VUMBNWg3g5mdORe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00012A5F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293bdc4d-fccb-4259-302e-08dc2297ff30
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 20:05:39.6468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ti1/JNS3iYAxo67ASNEr6ujuTX8JICb3ki3bHy5yuUTa3k7t3gERaKwol5ZOedEmtJugJ729MLBY+YnfLtqlmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1460



> -----Original Message-----
> From: Dexuan Cui <decui@microsoft.com>
> Sent: Wednesday, January 31, 2024 12:40 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Wei Liu <wei.liu@kernel.org>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Wojciech Drewek <wojciech.drewek@intel.com>; linux-
> hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Shradha Gupta <shradhagupta@microsoft.com>;
> stable@vger.kernel.org
> Subject: RE: [PATCH] hv_netvsc:Register VF in netvsc_probe if
> NET_DEVICE_REGISTER missed
>=20
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> > Sent: Wednesday, January 31, 2024 8:46 AM
> >  [...]
> > > From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > Sent: Wednesday, January 31, 2024 2:54 AM
> > > > [...]
> > > > > +		netvsc_prepare_bonding(vf_netdev);
> > > > > +		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
> > > > > +		__netvsc_vf_setup(net, vf_netdev);
> > > >
> > > > add a "break;' ?
> > > With MANA devices and multiport support there, the individual ports
> are
> > > also net_devices.
> > > Wouldn't this be needed for such scenario(where we have multiple mana
> > > port net devices) to
> > > register them all?
> >
> > Each device has separate probe() call, so only one VF will match in one
> > netvsc_probe().
> >
> > netvsc_prepare_bonding() &  netvsc_register_vf() have
> > get_netvsc_byslot(vf_netdev), but __netvsc_vf_setup() doesn't have. So,
> > in case of multi-Vfs, this code will run "this" netvsc NIC with
> multiple VFs by
> > __netvsc_vf_setup() which isn't correct.
> >
> > You need to add the following lines before
> > netvsc_prepare_bonding(vf_netdev)
> > in netvsc_probe() to skip non-matching VFs:
> >
> > if (net !=3D get_netvsc_byslot(vf_netdev))
> > 	continue;
>=20
> Haiyang is correct.
> I think it's still good to add a "break;", e.g. my understanding is
> something
> like the below (this is untested):
>=20
> +static struct net_device *get_matching_netvsc_dev(net_device
> *event_ndev)
> +{
> +       /* Skip NetVSC interfaces */
> +       if (event_ndev->netdev_ops =3D=3D &device_ops)
> +               return NULL;
> +
> +       /* Avoid non-Ethernet type devices */
> +       if (event_ndev->type !=3D ARPHRD_ETHER)
> +               return NULL;
> +
> +       /* Avoid Vlan dev with same MAC registering as VF */
> +       if (is_vlan_dev(event_ndev))
> +               return NULL;
> +
> +       /* Avoid Bonding master dev with same MAC registering as VF */
> +       if (netif_is_bond_master(event_ndev))
> +               return NULL;
> +
> +       return get_netvsc_byslot(event_ndev);
> +}

Looks good.=20
But, like you said before, the four if's can be moved into a new function,
and shared by two callers: netvsc_probe() & netvsc_netdev_event().


>=20
> +	for_each_netdev(dev_net(net), vf_netdev) {
> + 		if (get_matching_netvsc_dev(event_dev) !=3D net)
> +			continue;
> +
> +		netvsc_prepare_bonding(vf_netdev);
> +		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
> +		__netvsc_vf_setup(net, vf_netdev);
> +
> +		break;
> +	}
>=20
> We can also use get_matching_netvsc_dev() in netvsc_netdev_event().

netvsc_netdev_event() >> netvsc_unregister_vf() uses get_netvsc_byref(vf_ne=
tdev)
instead of get_netvsc_byslot().
So probably just re-factoring the four if's is better.

Thanks,
-Haiyang

