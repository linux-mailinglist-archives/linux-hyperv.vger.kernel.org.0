Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ECC27E937
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Sep 2020 15:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgI3NIa (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Sep 2020 09:08:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:4048 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3NIa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Sep 2020 09:08:30 -0400
IronPort-SDR: +Wso0RloPbEgnNBHl2XmoS53z1e0tyEAJmL3ClISb14O9I0oCT6V1ETop5MUYBV7KmqmmEaexj
 9TtQwjyOReiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="161663924"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="161663924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 06:08:29 -0700
IronPort-SDR: 7s2UjCbfKUqBwDv/XvMW3S47VDpzGckwYBowePWDcL41i65KVN689X/0oxm6L0Yb63h8tgLizY
 Uxws7zv6TMRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457649639"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 30 Sep 2020 06:08:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Sep 2020 06:08:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 30 Sep 2020 06:08:27 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Wed, 30 Sep 2020 06:08:27 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "sivanich@hpe.com" <sivanich@hpe.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "steve.wahl@hpe.com" <steve.wahl@hpe.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rja@hpe.com" <rja@hpe.com>, "joro@8bytes.org" <joro@8bytes.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [patch V2 24/46] PCI: vmd: Mark VMD irqdomain with
 DOMAIN_BUS_VMD_MSI
Thread-Topic: [patch V2 24/46] PCI: vmd: Mark VMD irqdomain with
 DOMAIN_BUS_VMD_MSI
Thread-Index: AQHWe6Ci+RtSrJb+okaPJR2eu/FJZalSxzQAgC8GCICAAANhgIAAAwyA
Date:   Wed, 30 Sep 2020 13:08:27 +0000
Message-ID: <97a8605902a7ee9f17af471458d1fe3029f2ad20.camel@intel.com>
References: <20200826111628.794979401@linutronix.de>
         <20200826112333.047315047@linutronix.de>
         <20200831143940.GA1152540@nvidia.com>
         <1d284a478d4e5bf4a247ee83afa1b8b45f9e1b3f.camel@intel.com>
         <20200930125733.GI816047@nvidia.com>
In-Reply-To: <20200930125733.GI816047@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8974402C8B105498508BBB556348F59@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

K01lZ2hhDQoNCk9uIFdlZCwgMjAyMC0wOS0zMCBhdCAwOTo1NyAtMDMwMCwgSmFzb24gR3VudGhv
cnBlIHdyb3RlOg0KPiBPbiBXZWQsIFNlcCAzMCwgMjAyMCBhdCAxMjo0NTozMFBNICswMDAwLCBE
ZXJyaWNrLCBKb25hdGhhbiB3cm90ZToNCj4gPiBIaSBKYXNvbg0KPiA+IA0KPiA+IE9uIE1vbiwg
MjAyMC0wOC0zMSBhdCAxMTozOSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+ID4g
T24gV2VkLCBBdWcgMjYsIDIwMjAgYXQgMDE6MTY6NTJQTSArMDIwMCwgVGhvbWFzIEdsZWl4bmVy
IHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5k
ZT4NCj4gPiA+ID4gDQo+ID4gPiA+IERldmljZXMgb24gdGhlIFZNRCBidXMgdXNlIHRoZWlyIG93
biBNU0kgaXJxIGRvbWFpbiwgYnV0IGl0IGlzIG5vdA0KPiA+ID4gPiBkaXN0aW5ndWlzaGFibGUg
ZnJvbSByZWd1bGFyIFBDSS9NU0kgaXJxIGRvbWFpbnMuIFRoaXMgaXMgcmVxdWlyZWQNCj4gPiA+
ID4gdG8gZXhjbHVkZSBWTUQgZGV2aWNlcyBmcm9tIGdldHRpbmcgdGhlIGlycSBkb21haW4gcG9p
bnRlciBzZXQgYnkNCj4gPiA+ID4gaW50ZXJydXB0IHJlbWFwcGluZy4NCj4gPiA+ID4gDQo+ID4g
PiA+IE92ZXJyaWRlIHRoZSBkZWZhdWx0IGJ1cyB0b2tlbi4NCj4gPiA+ID4gDQo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiA+ID4g
PiBBY2tlZC1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gPiA+ID4g
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCAgICA2ICsrKysrKw0KPiA+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gKysrIGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci92bWQuYw0KPiA+ID4gPiBAQCAtNTc5LDYgKzU3OSwxMiBAQCBz
dGF0aWMgaW50IHZtZF9lbmFibGVfZG9tYWluKHN0cnVjdCB2bWRfDQo+ID4gPiA+ICAJCXJldHVy
biAtRU5PREVWOw0KPiA+ID4gPiAgCX0NCj4gPiA+ID4gIA0KPiA+ID4gPiArCS8qDQo+ID4gPiA+
ICsJICogT3ZlcnJpZGUgdGhlIGlycSBkb21haW4gYnVzIHRva2VuIHNvIHRoZSBkb21haW4gY2Fu
IGJlIGRpc3Rpbmd1aXNoZWQNCj4gPiA+ID4gKwkgKiBmcm9tIGEgcmVndWxhciBQQ0kvTVNJIGRv
bWFpbi4NCj4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gKwlpcnFfZG9tYWluX3VwZGF0ZV9idXNfdG9r
ZW4odm1kLT5pcnFfZG9tYWluLCBET01BSU5fQlVTX1ZNRF9NU0kpOw0KPiA+ID4gPiArDQo+ID4g
PiANCj4gPiA+IEhhdmluZyB0aGUgbm9uLXRyYW5zcGFyZW50LWJyaWRnZSBob2xkIGEgTVNJIHRh
YmxlIGFuZA0KPiA+ID4gbXVsdGlwbGV4L2RlLW11bHRpcGxleCBJUlFzIGxvb2tzIGxpa2UgYW5v
dGhlciBnb29kIHVzZSBjYXNlIGZvcg0KPiA+ID4gc29tZXRoaW5nIGNsb3NlIHRvIHBjaV9zdWJk
ZXZpY2VfbXNpX2NyZWF0ZV9pcnFfZG9tYWluKCk/DQo+ID4gPiANCj4gPiA+IElmIGVhY2ggZGV2
aWNlIGNvdWxkIGhhdmUgaXRzIG93biBpbnRlcm5hbCBNU0ktWCB0YWJsZSBwcm9ncmFtbWVkDQo+
ID4gPiBwcm9wZXJseSB0aGluZ3Mgd291bGQgd29yayBhbG90IGJldHRlci4gRGlzYWJsZSBjYXB0
dXJlL3JlbWFwIG9mIHRoZQ0KPiA+ID4gTVNJIHJhbmdlIGluIHRoZSBOVEIuDQo+ID4gV2UgY2Fu
IGRpc2FibGUgdGhlIGNhcHR1cmUgYW5kIHJlbWFwIGluIG5ld2VyIGRldmljZXMgc28gd2UgZG9u
J3QgZXZlbg0KPiA+IG5lZWQgdGhlIGlycSBkb21haW4uDQo+IA0KPiBZb3UnZCBzdGlsbCBuZWVk
IGFuIGlycSBkb21haW4sIGl0IGp1c3QgY29tZXMgZnJvbQ0KPiBwY2lfc3ViZGV2aWNlX21zaV9j
cmVhdGVfaXJxX2RvbWFpbigpIGluc3RlYWQgb2YgaW50ZXJuYWwgdG8gdGhpcw0KPiBkcml2ZXIu
DQpJIGhhdmUgdGhpcyBzZXQgd2hpY2ggZGlzYWJsZXMgcmVtYXBwaW5nIGFuZCBieXBhc3NlcyB0
aGUgY3JlYXRpb24gb2YNCnRoZSBJUlEgZG9tYWluOg0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9saXN0Lz9zZXJpZXM9MTkyOTM2DQoNCkl0IGFsbG93cyB0
aGUgZW5kLWRldmljZXMgbGlrZSBOVk1lIHRvIGRpcmVjdGx5IG1hbmFnZXIgdGhlaXIgb3duDQpp
bnRlcnJ1cHRzIGFuZCBlbGltaW5hdGVzIHRoZSBWTUQgaW50ZXJydXB0IGNvbXBsZXRlbHkuIFRo
ZSBvbmx5IHF1aXJrDQp3YXMgdGhhdCBrZXJuZWwgaGFzIHRvIHByb2dyYW0gSVJURSB3aXRoIHRo
ZSBWTUQgZGV2aWNlIElEIGFzIGl0IHN0aWxsDQpyZW1hcHMgUmVxdWVzdGVyLUlEIGZyb20gc3Vi
ZGV2aWNlcy4NCg0KPiANCj4gPiBJIHdvdWxkIGhvd2V2ZXIgbGlrZSB0byBkZXRlcm1pbmUgaWYg
dGhlIE1TSSBkYXRhIGJpdHMgY291bGQgYmUgdXNlZA0KPiA+IGZvciBpbmRpdmlkdWFsIGRldmlj
ZXMgdG8gaGF2ZSB0aGUgSVJRIGRvbWFpbiBzdWJzeXN0ZW0gZGVtdWx0aXBsZXggdGhlDQo+ID4g
dmlycSBmcm9tIHRoYXQgYW5kIGVsaW1pbmF0ZSB0aGUgSVJRIGxpc3QgaXRlcmF0aW9uLg0KPiAN
Cj4gWWVzLCBleGFjdGx5LiBUaGlzIG5ldyBwY2lfc3ViZGV2aWNlX21zaV9jcmVhdGVfaXJxX2Rv
bWFpbigpIGNyZWF0ZXMNCj4gKnByb3BlciogZnVsbHkgZnVuY3Rpb25hbCBpbnRlcnJ1cHRzLCBu
byBuZWVkIGZvciBhbnkgSVJRIGhhbmRsZXIgaW4NCj4gdGhpcyBkcml2ZXIuDQo+IA0KPiA+IEEg
Y29uY2VybiBJIGhhdmUgYWJvdXQgdGhhdCBzY2hlbWUgaXMgdmlydHVhbGl6YXRpb24gYXMgSSB0
aGluayB0aG9zZQ0KPiA+IGJpdHMgYXJlIHVzZWQgdG8gcm91dGUgdG8gdGhlIHZpcnR1YWwgdmVj
dG9yLg0KPiANCj4gSXQgc2hvdWxkIGJlIGZpbmUgd2l0aCB0aGlzIHBhdGNoIHNlcmllcywgY29u
c3VsdCB3aXRoIE1lZ2hhIGhvdw0KPiB2aXJ0dWFsaXphdGlvbiBpcyB3b3JraW5nIHdpdGggSURY
RC9ldGMNCj4gDQo+IEphc29uDQo=
