Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C91252E81
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgHZMOh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 08:14:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgHZMBC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 08:01:02 -0400
Message-Id: <20200826111628.794979401@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598443255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1dVHGWlVLKe8Qbq+hsxoxDKyLgFehj4bg/2iuhvz548=;
        b=itgEGCH2EzpbaFlCSN0K2oYg5CLEFENc6q3co7bhBruz4euEviEZAzZO5a/j+gLiSTVNYi
        3VbpDIuO0f71j8jusJl+pz8zfoOKAPxl0ZiBSKO8hAOHE2808wxZR4DLH3Q57bnO9gbygy
        nN6nh3CZL2WeZyV2bc6JFQXFwgcf6kQcwSbeBBFXPbKGHX/DJCyUz5PXbE+gKlr/tIKFIL
        8YRsRO1izHB+wsCmHWwcn/mtGfRA/AVPhXtma7nQ8VDHQ3EDaHY+FrrXT6fbPBAWXingVv
        Ybpb3NGiWx9eomJIsuWMLmcM1uG5/+DDmvRMR/InX6WcXy8QMIcaoFMTKEZyhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598443255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1dVHGWlVLKe8Qbq+hsxoxDKyLgFehj4bg/2iuhvz548=;
        b=jQX1nfcbMl4rnDTp2/mDJdszSt8UAxcBp/X1rcZbQLBpuHBU67ldyCtMUmpEbCjrwlsJCm
        LETm99a7F7lunACQ==
Date:   Wed, 26 Aug 2020 13:16:28 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VGhpcyBpcyB0aGUgc2Vjb25kIHZlcnNpb24gb2YgcHJvdmlkaW5nIGEgYmFzZSB0byBzdXBwb3J0
IGRldmljZSBNU0kgKG5vbgpQQ0kgYmFzZWQpIGFuZCBvbiB0b3Agb2YgdGhhdCBzdXBwb3J0IGZv
ciBJTVMgKEludGVycnVwdCBNZXNzYWdlIFN0b3JtKQpiYXNlZCBkZXZpY2VzIGluIGEgaGFsZndh
eXMgYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IHdheS4KClRoZSBmaXJzdCB2ZXJzaW9uIGNhbiBi
ZSBmb3VuZCBoZXJlOgoKICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMDA4MjEwMDI0
MjQuMTE5NDkyMjMxQGxpbnV0cm9uaXguZGUKCkl0J3Mgc3RpbGwgYSBtaXhlZCBiYWcgb2YgYnVn
IGZpeGVzLCBjbGVhbnVwcyBhbmQgZ2VuZXJhbCBpbXByb3ZlbWVudHMKd2hpY2ggYXJlIHdvcnRo
d2hpbGUgaW5kZXBlbmRlbnQgb2YgZGV2aWNlIE1TSS4KClRoZXJlIGFyZSBxdWl0ZSBhIGJ1bmNo
IG9mIGlzc3VlcyB0byBzb2x2ZToKCiAgLSBYODYgZG9lcyBub3QgdXNlIHRoZSBkZXZpY2U6Om1z
aV9kb21haW4gcG9pbnRlciBmb3IgaGlzdG9yaWNhbCByZWFzb25zCiAgICBhbmQgZHVlIHRvIFhF
Tiwgd2hpY2ggbWFrZXMgaXQgaW1wb3NzaWJsZSB0byBjcmVhdGUgYW4gYXJjaGl0ZWN0dXJlCiAg
ICBhZ25vc3RpYyBkZXZpY2UgTVNJIGluZnJhc3RydWN0dXJlLgoKICAtIFg4NiBoYXMgaXQncyBv
d24gbXNpX2FsbG9jX2luZm8gZGF0YSB0eXBlIHdoaWNoIGlzIHBvaW50bGVzc2x5CiAgICBkaWZm
ZXJlbnQgZnJvbSB0aGUgZ2VuZXJpYyB2ZXJzaW9uIGFuZCBkb2VzIG5vdCBhbGxvdyB0byBzaGFy
ZSBjb2RlLgoKICAtIFRoZSBsb2dpYyBvZiBjb21wb3NpbmcgTVNJIG1lc3NhZ2VzIGluIGFuIGhp
ZXJhcmNoeSBpcyBidXN0ZWQgYXQgdGhlCiAgICBjb3JlIGxldmVsIGFuZCBvZiBjb3Vyc2Ugc29t
ZSAoeDg2KSBkcml2ZXJzIGRlcGVuZCBvbiB0aGF0LgoKICAtIEEgZmV3IG1pbm9yIHNob3J0Y29t
aW5ncyBhcyB1c3VhbAoKVGhpcyBzZXJpZXMgYWRkcmVzc2VzIHRoYXQgaW4gc2V2ZXJhbCBzdGVw
czoKCiAxKSBBY2NpZGVudGFsIGJ1ZyBmaXhlcwoKICAgICAgaW9tbXUvYW1kOiBQcmV2ZW50IE5V
TEwgcG9pbnRlciBkZXJlZmVyZW5jZQoKIDIpIEphbml0b3JpbmcKCiAgICAgIHg4Ni9pbml0OiBS
ZW1vdmUgdW51c2VkIGluaXQgb3BzCiAgICAgIFBDSTogdm1kOiBEb250IGFidXNlIHZlY3RvciBp
cnFvbWFpbiBhcyBwYXJlbnQKICAgICAgeDg2L21zaTogUmVtb3ZlIHBvaW50bGVzcyB2Y3B1X2Fm
ZmluaXR5IGNhbGxiYWNrCgogMykgU2FuaXRpemluZyB0aGUgY29tcG9zaXRpb24gb2YgTVNJIG1l
c3NhZ2VzIGluIGEgaGllcmFyY2h5CiAKICAgICAgZ2VuaXJxL2NoaXA6IFVzZSB0aGUgZmlyc3Qg
Y2hpcCBpbiBpcnFfY2hpcF9jb21wb3NlX21zaV9tc2coKQogICAgICB4ODYvbXNpOiBNb3ZlIGNv
bXBvc2UgbWVzc2FnZSBjYWxsYmFjayB3aGVyZSBpdCBiZWxvbmdzCgogNCkgU2ltcGxpZmljYXRp
b24gb2YgdGhlIHg4NiBzcGVjaWZpYyBpbnRlcnJ1cHQgYWxsb2NhdGlvbiBtZWNoYW5pc20KCiAg
ICAgIHg4Ni9pcnE6IFJlbmFtZSBYODZfSVJRX0FMTE9DX1RZUEVfTVNJKiB0byByZWZsZWN0IFBD
SSBkZXBlbmRlbmN5CiAgICAgIHg4Ni9pcnE6IEFkZCBhbGxvY2F0aW9uIHR5cGUgZm9yIHBhcmVu
dCBkb21haW4gcmV0cmlldmFsCiAgICAgIGlvbW11L3Z0LWQ6IENvbnNvbGlkYXRlIGlycSBkb21h
aW4gZ2V0dGVyCiAgICAgIGlvbW11L2FtZDogQ29uc29saWRhdGUgaXJxIGRvbWFpbiBnZXR0ZXIK
ICAgICAgaW9tbXUvaXJxX3JlbWFwcGluZzogQ29uc29saWRhdGUgaXJxIGRvbWFpbiBsb29rdXAK
CiA1KSBDb25zb2xpZGF0aW9uIG9mIHRoZSBYODYgc3BlY2lmaWMgaW50ZXJydXB0IGFsbG9jYXRp
b24gbWVjaGFuaXNtIHRvIGJlIGFzIGNsb3NlCiAgICBhcyBwb3NzaWJsZSB0byB0aGUgZ2VuZXJp
YyBNU0kgYWxsb2NhdGlvbiBtZWNoYW5pc20gd2hpY2ggYWxsb3dzIHRvIGdldCByaWQKICAgIG9m
IHF1aXRlIGEgYnVuY2ggb2YgeDg2J2lzbXMgd2hpY2ggYXJlIHBvaW50bGVzcwoKICAgICAgeDg2
L2lycTogUHJlcGFyZSBjb25zb2xpZGF0aW9uIG9mIGlycV9hbGxvY19pbmZvCiAgICAgIHg4Ni9t
c2k6IENvbnNvbGlkYXRlIEhQRVQgYWxsb2NhdGlvbgogICAgICB4ODYvaW9hcGljOiBDb25zb2xp
ZGF0ZSBJT0FQSUMgYWxsb2NhdGlvbgogICAgICB4ODYvaXJxOiBDb25zb2xpZGF0ZSBETUFSIGly
cSBhbGxvY2F0aW9uCiAgICAgIHg4Ni9pcnE6IENvbnNvbGlkYXRlIFVWIGRvbWFpbiBhbGxvY2F0
aW9uCiAgICAgIFBDSS9NU0k6IFJld29yayBwY2lfbXNpX2RvbWFpbl9jYWxjX2h3aXJxKCkKICAg
ICAgeDg2L21zaTogQ29uc29saWRhdGUgTVNJIGFsbG9jYXRpb24KICAgICAgeDg2L21zaTogVXNl
IGdlbmVyaWMgTVNJIGRvbWFpbiBvcHMKCiAgNikgeDg2IHNwZWNpZmljIGNsZWFudXBzIHRvIHJl
bW92ZSB0aGUgZGVwZW5kZW5jeSBvbiBhcmNoXypfbXNpX2lycXMoKQoKICAgICAgeDg2L2lycTog
TW92ZSBhcGljX3Bvc3RfaW5pdCgpIGludm9jYXRpb24gdG8gb25lIHBsYWNlCiAgICAgIHg4Ni9w
Y2k6IFJlZHVjZGUgI2lmZGVmZmVyeSBpbiBQQ0kgaW5pdCBjb2RlCiAgICAgIHg4Ni9pcnE6IElu
aXRpYWxpemUgUENJL01TSSBkb21haW4gYXQgUENJIGluaXQgdGltZQogICAgICBpcnFkb21haW4v
bXNpOiBQcm92aWRlIERPTUFJTl9CVVNfVk1EX01TSQogICAgICBQQ0k6IHZtZDogTWFyayBWTUQg
aXJxZG9tYWluIHdpdGggRE9NQUlOX0JVU19WTURfTVNJCiAgICAgIFBDSS9NU0k6IFByb3ZpZGUg
cGNpX2Rldl9oYXNfc3BlY2lhbF9tc2lfZG9tYWluKCkgaGVscGVyCiAgICAgIHg4Ni94ZW46IE1h
a2UgeGVuX21zaV9pbml0KCkgc3RhdGljIGFuZCByZW5hbWUgaXQgdG8geGVuX2h2bV9tc2lfaW5p
dCgpCiAgICAgIHg4Ni94ZW46IFJld29yayBNU0kgdGVhcmRvd24KICAgICAgeDg2L3hlbjogQ29u
c29saWRhdGUgWEVOLU1TSSBpbml0CiAgICAgIGlycWRvbWFpbi9tc2k6IEFsbG93IHRvIG92ZXJy
aWRlIG1zaV9kb21haW5fYWxsb2MvZnJlZV9pcnFzKCkKICAgICAgeDg2L3hlbjogV3JhcCBYRU4g
TVNJIG1hbmFnZW1lbnQgaW50byBpcnFkb21haW4KICAgICAgaW9tbW0vdnQtZDogU3RvcmUgaXJx
IGRvbWFpbiBpbiBzdHJ1Y3QgZGV2aWNlCiAgICAgIGlvbW1tL2FtZDogU3RvcmUgaXJxIGRvbWFp
biBpbiBzdHJ1Y3QgZGV2aWNlCiAgICAgIHg4Ni9wY2k6IFNldCBkZWZhdWx0IGlycSBkb21haW4g
aW4gcGNpYmlvc19hZGRfZGV2aWNlKCkKICAgICAgUENJL01TSTogTWFrZSBhcmNoXy4qX21zaV9p
cnFbc10gZmFsbGJhY2tzIHNlbGVjdGFibGUKICAgICAgeDg2L2lycTogQ2xlYW51cCB0aGUgYXJj
aF8qX21zaV9pcnFzKCkgbGVmdG92ZXJzCiAgICAgIHg4Ni9pcnE6IE1ha2UgbW9zdCBNU0kgb3Bz
IFhFTiBwcml2YXRlCiAgICAgIGlvbW11L3Z0LWQ6IFJlbW92ZSBkb21haW4gc2VhcmNoIGZvciBQ
Q0kvTVNJW1hdCiAgICAgIGlvbW11L2FtZDogUmVtb3ZlIGRvbWFpbiBzZWFyY2ggZm9yIFBDSS9N
U0kKCiAgNykgWDg2IHNwZWNpZmljIHByZXBhcmF0aW9uIGZvciBkZXZpY2UgTVNJCgogICAgICB4
ODYvaXJxOiBBZGQgREVWX01TSSBhbGxvY2F0aW9uIHR5cGUKICAgICAgeDg2L21zaTogUmVuYW1l
IGFuZCByZXdvcmsgcGNpX21zaV9wcmVwYXJlKCkgdG8gY292ZXIgbm9uLVBDSSBNU0kKCiAgOCkg
R2VuZXJpYyBkZXZpY2UgTVNJIGluZnJhc3RydWN0dXJlCiAgICAgIHBsYXRmb3JtLW1zaTogUHJv
dmlkZSBkZWZhdWx0IGlycV9jaGlwOjogQWNrCiAgICAgIGdlbmlycS9wcm9jOiBUYWtlIGJ1c2xv
Y2sgb24gYWZmaW5pdHkgd3JpdGUKICAgICAgZ2VuaXJxL21zaTogUHJvdmlkZSBhbmQgdXNlIG1z
aV9kb21haW5fc2V0X2RlZmF1bHRfaW5mb19mbGFncygpCiAgICAgIHBsYXRmb3JtLW1zaTogQWRk
IGRldmljZSBNU0kgaW5mcmFzdHJ1Y3R1cmUKICAgICAgaXJxZG9tYWluL21zaTogUHJvdmlkZSBt
c2lfYWxsb2MvZnJlZV9zdG9yZSgpIGNhbGxiYWNrcwoKICA5KSBQT0Mgb2YgSU1TIChJbnRlcnJ1
cHQgTWVzc2FnZSBTdG9ybSkgaXJxIGRvbWFpbiBhbmQgaXJxY2hpcAogICAgIGltcGxlbWVudGF0
aW9ucyBmb3IgYm90aCBkZXZpY2UgYXJyYXkgYW5kIHF1ZXVlIHN0b3JhZ2UuCgogICAgICBpcnFj
aGlwOiBBZGQgSU1TIChJbnRlcnJ1cHQgTWVzc2FnZSBTdG9ybSkgZHJpdmVyIC0gTk9UIEZPUiBN
RVJHSU5HCgpDaGFuZ2VzIHZzLiBWMToKCiAgIC0gQWRkcmVzc2VkIHZhcmlvdXMgcmV2aWV3IGNv
bW1lbnRzIGFuZCBhZGRyZXNzZWQgdGhlIDBkYXkgZmFsbG91dC4KICAgICAtIENvcnJlY3RlZCB0
aGUgWEVOIGxvZ2ljIChKw7xyZ2VuKQogICAgIC0gTWFrZSB0aGUgYXJjaCBmYWxsYmFjayBpbiBQ
Q0kvTVNJIG9wdC1pbiBub3Qgb3B0LW91dCAoQmpvcm4pCgogICAtIEZpeGVkIHRoZSBjb21wb3Nl
IE1TSSBtZXNzYWdlIGluY29uc2lzdGVuY3kKCiAgIC0gRW5zdXJlIHRoYXQgdGhlIG5lY2Vzc2Fy
eSBmbGFncyBhcmUgc2V0IGZvciBkZXZpY2UgU01JCgogICAtIE1ha2UgdGhlIGlycSBidXMgbG9n
aWMgd29yayBmb3IgYWZmaW5pdHkgc2V0dGluZyB0byBwcmVwYXJlCiAgICAgc3VwcG9ydCBmb3Ig
SU1TIHN0b3JhZ2UgaW4gcXVldWUgbWVtb3J5LiBJdCB0dXJuZWQgb3V0IHRvIGJlCiAgICAgbGVz
cyBzY2FyeSB0aGFuIEkgZmVhcmVkLgoKICAgLSBSZW1vdmUgbGVmdG92ZXJzIGluIGlvbW11L2lu
dGVsfGFtZAoKICAgLSBSZXdvcmtlZCB0aGUgSU1TIFBPQyBkcml2ZXIgdG8gY292ZXIgcXVldWUg
c3RvcmFnZSBzbyBKYXNvbiBjYW4gaGF2ZSBhCiAgICAgbG9vayB3aGV0aGVyIHRoYXQgZml0cyB0
aGUgbmVlZHMgb2YgTUxYIGRldmljZXMuCgpUaGUgd2hvbGUgbG90IGlzIGFsc28gYXZhaWxhYmxl
IGZyb20gZ2l0OgoKICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RnbHgvZGV2ZWwuZ2l0IGRldmljZS1tc2kKClRoaXMgaGFzIGJlZW4gdGVzdGVkIG9uIElu
dGVsL0FNRC9LVk0gYnV0IGxhY2tzIHRlc3Rpbmcgb246CgogICAgLSBIWVBFUlYgKC1FTk9ERVYp
CiAgICAtIFZNRCBlbmFibGVkIHN5c3RlbXMgKC1FTk9ERVYpCiAgICAtIFhFTiAoLUVOT0NMVUUp
CiAgICAtIElNUyAoLUVOT0RFVikKCiAgICAtIEFueSBub24tWDg2IGNvZGUgd2hpY2ggbWlnaHQg
ZGVwZW5kIG9uIHRoZSBicm9rZW4gY29tcG9zZSBNU0kgbWVzc2FnZQogICAgICBsb2dpYy4gTWFy
YyBleGNwZWN0cyBub3QgbXVjaCBmYWxsb3V0LCBidXQgYWdyZWVzIHRoYXQgd2UgbmVlZCB0byBm
aXgKICAgICAgaXQgYW55d2F5LgoKIzEgLSAjMyBzaG91bGQgYmUgYXBwbGllZCB1bmNvbmRpdGlv
bmFsbHkgZm9yIG9idmlvdXMgcmVhc29ucwojNCAtICM2IGFyZSB3b3J0d2hpbGUgY2xlYW51cHMg
d2hpY2ggc2hvdWxkIGJlIGRvbmUgaW5kZXBlbmRlbnQgb2YgZGV2aWNlIE1TSQoKIzcgLSAjOCBs
b29rIHByb21pc2luZyB0byBjbGVhbnVwIHRoZSBwbGF0Zm9ybSBNU0kgaW1wbGVtZW50YXRpb24K
ICAgICAJaW5kZXBlbmRlbnQgb2YgIzgsIGJ1dCBJIG5laXRoZXIgaGFkIGN5Y2xlcyBub3IgdGhl
IHN0b21hY2ggdG8KICAgICAJdGFja2xlIHRoYXQuCgojOQlpcyBvYnZpb3VzbHkganVzdCBmb3Ig
dGhlIGZvbGtzIGludGVyZXN0ZWQgaW4gSU1TCgpUaGFua3MsCgoJdGdseAo=
