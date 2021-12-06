Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4841C46AB65
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Dec 2021 23:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbhLFWaz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Dec 2021 17:30:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242901AbhLFWay (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Dec 2021 17:30:54 -0500
Message-ID: <20211206210147.872865823@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638829644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TvVbtaLszVomfbTSaDkZ3Si83Q0PTUXmzyd/sxp3aOQ=;
        b=2PszHZiuiUTEj+gbLOwH5J07JyOXMbPmbCF5/f0ECB+TDx6fg7HRqd/7nSafRiLEh/tB2J
        I89obIOz4EfihV8wPu6DVbEqAjw/vu0lG3MVaBJQOCX84dIVCgJcpP/4YaTYj0DWyUOU+p
        QY7yu7nySNOGDJllJoRD8mO5pRKX6dZ+TpEE7VtehF+zj9YNKxWJrbFRJPs4IpnpV7iPLb
        eXidnoRUF/iI20Q4u50DI+RHcaKyBY/xpS4sXM1RqwV+zb/rkRAS11jus+lRlFQbQ+/IC4
        zfPKJkcA3/LscOUNOfG7uESwv6dj4mHkFlfcsQphYvz9RbwoDVZGHnz96iSF7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638829644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TvVbtaLszVomfbTSaDkZ3Si83Q0PTUXmzyd/sxp3aOQ=;
        b=dTYY6yq8X+q85zEA0MFqc5lmEol5cxwjMuFVu15JeS/3f+qTFpB+7//Ug3/O6D2uzzNFJo
        H/Ml5sGXok1eYqCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparclinux@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, ath11k@lists.infradead.org,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [patch V2 00/23] genirq/msi, PCI/MSI: Spring cleaning - Part 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon,  6 Dec 2021 23:27:23 +0100 (CET)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VGhlIFtQQ0ldIE1TSSBjb2RlIGhhcyBnYWluZWQgcXVpdGUgc29tZSB3YXJ0cyBvdmVyIHRpbWUu
IEEgcmVjZW50CmRpc2N1c3Npb24gdW5lYXJ0aGVkIGEgc2hvcnRjb21pbmc6IHRoZSBsYWNrIG9m
IHN1cHBvcnQgZm9yIGV4cGFuZGluZwpQQ0kvTVNJLVggdmVjdG9ycyBhZnRlciBpbml0aWFsaXph
dGlvbiBvZiBNU0ktWC4KClBDSS9NU0ktWCBoYXMgbm8gcmVxdWlyZW1lbnQgdG8gc2V0dXAgYWxs
IHZlY3RvcnMgd2hlbiBNU0ktWCBpcyBlbmFibGVkIGluCnRoZSBkZXZpY2UuIFRoZSBub24tdXNl
ZCB2ZWN0b3JzIGhhdmUganVzdCB0byBiZSBtYXNrZWQgaW4gdGhlIHZlY3Rvcgp0YWJsZS4gRm9y
IFBDSS9NU0kgdGhpcyBpcyBub3QgcG9zc2libGUgYmVjYXVzZSB0aGUgbnVtYmVyIG9mIHZlY3Rv
cnMKY2Fubm90IGJlIGNoYW5nZWQgYWZ0ZXIgaW5pdGlhbGl6YXRpb24uCgpUaGUgUENJL01TSSBj
b2RlLCBidXQgYWxzbyB0aGUgY29yZSBNU0kgaXJxIGRvbWFpbiBjb2RlIGFyZSBidWlsdCBhcm91
bmQKdGhlIGFzc3VtcHRpb24gdGhhdCBhbGwgcmVxdWlyZWQgdmVjdG9ycyBhcmUgaW5zdGFsbGVk
IGF0IGluaXRpYWxpemF0aW9uCnRpbWUgYW5kIGZyZWVkIHdoZW4gdGhlIGRldmljZSBpcyBzaHV0
IGRvd24gYnkgdGhlIGRyaXZlci4KClN1cHBvcnRpbmcgZHluYW1pYyBleHBhbnNpb24gYXQgbGVh
c3QgZm9yIE1TSS1YIGlzIGltcG9ydGFudCBmb3IgVkZJTyBzbwp0aGF0IHRoZSBob3N0IHNpZGUg
aW50ZXJydXB0cyBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlcyBjYW4gYmUgaW5zdGFsbGVkIG9uCmRl
bWFuZC4KClRoaXMgaXMgdGhlIGZpcnN0IHBhcnQgb2YgYSBsYXJnZSAodG90YWwgMTAxIHBhdGNo
ZXMpIHNlcmllcyB3aGljaApyZWZhY3RvcnMgdGhlIFtQQ0ldTVNJIGluZnJhc3RydWN0dXJlIHRv
IG1ha2UgcnVudGltZSBleHBhbnNpb24gb2YgTVNJLVgKdmVjdG9ycyBwb3NzaWJsZS4gVGhlIGxh
c3QgcGFydCAoMTAgcGF0Y2hlcykgcHJvdmlkZSB0aGlzIGZ1bmN0aW9uYWxpdHkuCgpUaGUgZmly
c3QgcGFydCBpcyBtb3N0bHkgYSBjbGVhbnVwIHdoaWNoIGNvbnNvbGlkYXRlcyBjb2RlLCBtb3Zl
cyB0aGUgUENJCk1TSSBjb2RlIGludG8gYSBzZXBhcmF0ZSBkaXJlY3RvcnkgYW5kIHNwbGl0cyBp
dCB1cCBpbnRvIHNldmVyYWwgcGFydHMuCgpObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZCBl
eGNlcHQgZm9yIHBhdGNoIDIvTiB3aGljaCBjaGFuZ2VzIHRoZQpiZWhhdmlvdXIgb2YgcGNpX2dl
dF92ZWN0b3IoKS9hZmZpbml0eSgpIHRvIGdldCByaWQgb2YgdGhlIGFzc3VtcHRpb24gdGhhdAp0
aGUgcHJvdmlkZWQgaW5kZXggaXMgdGhlICJpbmRleCIgaW50byB0aGUgZGVzY3JpcHRvciBsaXN0
IGluc3RlYWQgb2YgdXNpbmcKaXQgYXMgdGhlIGFjdHVhbCBNU0lbWF0gaW5kZXggYXMgc2VlbiBi
eSB0aGUgaGFyZHdhcmUuIFRoaXMgd291bGQgYnJlYWsKdXNlcnMgb2Ygc3BhcnNlIGFsbG9jYXRl
ZCBNU0ktWCBlbnRyaWVzLCBidXQgbm9uIG9mIHRoZW0gdXNlIHRoZXNlCmZ1bmN0aW9ucy4KClRo
aXMgc2VyaWVzIGlzIGJhc2VkIG9uIDUuMTYtcmMyIGFuZCBhbHNvIGF2YWlsYWJsZSB2aWEgZ2l0
OgoKICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgv
ZGV2ZWwuZ2l0IG1zaS12Mi1wYXJ0LTEKCkZvciB0aGUgY3VyaW91cyB3aG8gY2FuJ3Qgd2FpdCBm
b3IgdGhlIG5leHQgcGFydCB0byBhcnJpdmUgdGhlIGZ1bGwgc2VyaWVzCmlzIGF2YWlsYWJsZSB2
aWE6CgogICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGds
eC9kZXZlbC5naXQgbXNpLXYyLXBhcnQtMwoKVjEgb2YgdGhpcyBzZXJpZXMgY2FuIGJlIGZvdW5k
IGhlcmU6CgogICBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjExMTI2MjIyNzAwLjg2MjQw
Nzk3N0BsaW51dHJvbml4LmRlCgpDaGFuZ2VzIHZlcnN1cyBWMToKCiAgLSBBZGQgbWlzc2luZyBp
bmNsdWRlcyBhbmQgdXNlIGNvcnJlY3QgdmFyaWFibGUgbmFtZSBpbiBsZWdhY3kgY29kZSAtIENl
ZHJpYwoKICAtIE1vdmVkIHRoZSBNU0kgbG9jayBmcm9tIHN0cnVjdCBkZXZpY2UgdG8gc3RydWN0
IHBjaV9kZXYgLSBOZXcgcGF0Y2gKCiAgICBUaGlzIGlzIHJlYWxseSBQQ0kvTVNJIHNwZWNpZmlj
IGFuZCB0aGVyZSBpcyBubyBwb2ludCB0byBoYXZlIGl0CiAgICBpbiBldmVyeSBzdHJ1Y3QgZGV2
aWNlLiBOZWl0aGVyIGRvZXMgaXQgbWFrZSBzZW5zZSB0byBoaWRlIGl0CiAgICBpbiBtc2lfZGV2
aWNlX2RhdGEgYXMgdGhlIFYxIHNlcmllcyBwYXJ0IDIgZGlkLgoKICAtIFBpY2tlZCB1cCBSZXZp
ZXdlZC9UZXN0ZWQvQWNrZWQtYnkgdGFncyBhcyBhcHByb3ByaWF0ZQoKVGhhbmtzLAoKCXRnbHgK
LS0tCiBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzR4eC9tc2kuYyAgICAgICAgICAgIHwgIDI4MSAt
LS0tLS0tLS0tLS0KIGIvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3BjaS9wY2kucnN0ICAgICAg
fCAgICAyIAogYi9hcmNoL21pcHMvcGNpL21zaS1vY3Rlb24uYyAgICAgICAgICAgICAgICB8ICAg
MzIgLQogYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzR4eC9NYWtlZmlsZSAgICAgICB8ICAgIDEg
CiBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvY2VsbC9heG9uX21zaS5jICAgIHwgICAgMiAKIGIv
YXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BjaS1pb2RhLmMgfCAgICA0IAogYi9hcmNo
L3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvbXNpLmMgICAgICB8ICAgIDYgCiBiL2FyY2gvcG93
ZXJwYy9zeXNkZXYvS2NvbmZpZyAgICAgICAgICAgICAgIHwgICAgNiAKIGIvYXJjaC9zMzkwL3Bj
aS9wY2lfaXJxLmMgICAgICAgICAgICAgICAgICAgfCAgICA0IAogYi9hcmNoL3NwYXJjL2tlcm5l
bC9wY2lfbXNpLmMgICAgICAgICAgICAgICB8ICAgIDQgCiBiL2FyY2gveDg2L2h5cGVydi9pcnFk
b21haW4uYyAgICAgICAgICAgICAgIHwgICA1NSAtLQogYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS94
ODZfaW5pdC5oICAgICAgICAgICB8ICAgIDYgCiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3hlbi9o
eXBlcnZpc29yLmggICAgIHwgICAgOCAKIGIvYXJjaC94ODYva2VybmVsL2FwaWMvbXNpLmMgICAg
ICAgICAgICAgICAgfCAgICA4IAogYi9hcmNoL3g4Ni9rZXJuZWwveDg2X2luaXQuYyAgICAgICAg
ICAgICAgICB8ICAgMTIgCiBiL2FyY2gveDg2L3BjaS94ZW4uYyAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxOSAKIGIvZHJpdmVycy9iYXNlL2NvcmUuYyAgICAgICAgICAgICAgICAgICAgICAg
fCAgICAxIAogYi9kcml2ZXJzL2lycWNoaXAvaXJxLWdpYy12Mm0uYyAgICAgICAgICAgICB8ICAg
IDEgCiBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtZ2ljLXYzLWl0cy1wY2ktbXNpLmMgIHwgICAgMSAK
IGIvZHJpdmVycy9pcnFjaGlwL2lycS1naWMtdjMtbWJpLmMgICAgICAgICAgfCAgICAxIAogYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTFrL3BjaS5jICAgICB8ICAgIDIgCiBiL2RyaXZl
cnMvcGNpL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgIHwgICAgMyAKIGIvZHJpdmVycy9w
Y2kvbXNpL01ha2VmaWxlICAgICAgICAgICAgICAgICAgfCAgICA3IAogYi9kcml2ZXJzL3BjaS9t
c2kvaXJxZG9tYWluLmMgICAgICAgICAgICAgICB8ICAyNjcgKysrKysrKysrKysKIGIvZHJpdmVy
cy9wY2kvbXNpL2xlZ2FjeS5jICAgICAgICAgICAgICAgICAgfCAgIDc5ICsrKwogYi9kcml2ZXJz
L3BjaS9tc2kvbXNpLmMgICAgICAgICAgICAgICAgICAgICB8ICA2NDcgKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogYi9kcml2ZXJzL3BjaS9tc2kvbXNpLmggICAgICAgICAgICAgICAgICAg
ICB8ICAgMzkgKwogYi9kcml2ZXJzL3BjaS9tc2kvcGNpZGV2X21zaS5jICAgICAgICAgICAgICB8
ICAgNDMgKwogYi9kcml2ZXJzL3BjaS9wY2ktc3lzZnMuYyAgICAgICAgICAgICAgICAgICB8ICAg
IDcgCiBiL2RyaXZlcnMvcGNpL3Byb2JlLmMgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNCAK
IGIvZHJpdmVycy9wY2kveGVuLXBjaWZyb250LmMgICAgICAgICAgICAgICAgfCAgICAyIAogYi9p
bmNsdWRlL2xpbnV4L2RldmljZS5oICAgICAgICAgICAgICAgICAgICB8ICAgIDIgCiBiL2luY2x1
ZGUvbGludXgvbXNpLmggICAgICAgICAgICAgICAgICAgICAgIHwgIDEzNiArKy0tLQogYi9pbmNs
dWRlL2xpbnV4L3BjaS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgCiBiL2tlcm5lbC9p
cnEvbXNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0MSArCiAzNSBmaWxlcyBjaGFu
Z2VkLCA3MDIgaW5zZXJ0aW9ucygrKSwgMTAzMyBkZWxldGlvbnMoLSkKCg==
