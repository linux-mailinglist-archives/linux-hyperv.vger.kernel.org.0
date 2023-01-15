Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FB366B3D7
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Jan 2023 21:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjAOU2C (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Jan 2023 15:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjAOU2B (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Jan 2023 15:28:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF89CC3F;
        Sun, 15 Jan 2023 12:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hma09GUeOo7cUxAt1yb4jq2ttpTMOL2/HqikVNdDUyU=; b=ix779t5rx2ljo0GSoIwBMqI3Rp
        OWtSaolAWth33HaIaWD3AnpEL8qegqJKX0izXE4LzOvJbpL2q30iMd6YS2QAB6Ei/NelMPWV15Cka
        uLbXor+xf30XtMcF08VOmroAMeL4zq6BEll0+8XgCwbf7EYZdRZz1vkfUiA2gOZw3w/DNYCl8kH45
        HxL4qdy7h6nim4STkmhMYD8iJWbBsfGtOkZQLGR5Z+D1aA6SbufljKwQAent9aoQUuEzJ7Ab7sdkR
        rCi8FW30V+GbtGMcfTbZ9woeyz+sWAqtKVde/yuzu+o0TrbThbRYuOdu5VitP3E51U5OWa27g4+zr
        HJaSIzWA==;
Received: from [2001:8b0:10b:5::bb3] (helo=u3832b3a9db3152.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pH9bj-0087DO-2j; Sun, 15 Jan 2023 20:27:59 +0000
Message-ID: <b3e86a1c3c1b524bccdb71c837cb65fdf51495ff.camel@infradead.org>
Subject: Re: [patch V2 30/46] x86/xen: Wrap XEN MSI management into irqdomain
From:   David Woodhouse <dwmw2@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xen.org>
Cc:     Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
        Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>,
        x86@kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Megha Dey <megha.dey@intel.com>,
        xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Juergen Gross <jgross@suse.com>, Russ Anderson <rja@hpe.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 15 Jan 2023 20:27:44 +0000
In-Reply-To: <55f581345df465a73d6469f44d3512d9ccac7ffc.camel@infradead.org>
References: <20200826111628.794979401@linutronix.de>
         <20200826112333.622352798@linutronix.de>
         <55f581345df465a73d6469f44d3512d9ccac7ffc.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-fjKh0loIuJRGzJfL12nv"
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--=-fjKh0loIuJRGzJfL12nv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2023-01-15 at 14:12 +0000, David Woodhouse wrote:
> On Wed, 2020-08-26 at 13:16 +0200, Thomas Gleixner wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> >=20
> > To allow utilizing the irq domain pointer in struct device it is necess=
ary
> > to make XEN/MSI irq domain compatible.
> >=20
> > While the right solution would be to truly convert XEN to irq domains, =
this
> > is an exercise which is not possible for mere mortals with limited XENo=
logy.
> >=20
> > Provide a plain irqdomain wrapper around XEN. While this is blatant
> > violation of the irqdomain design, it's the only solution for a XEN igo=
rant
> > person to make progress on the issue which triggered this change.
> >=20
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Juergen Gross <jgross@suse.com>
>=20
> I think it broke MSI-X support, because xen_pci_msi_domain_info is
> lacking a .flags =3D MSI_FLAGS_PCI_MSIX?

Hm, I think it only actually *broke* with commit 99f3d27976 ("PCI/MSI:
Reject MSI-X early") from November last year. So 6.1 was OK and we have
time to fix it in 6.2.

Confirmed on real Xen at least that a Fedora 37 install with a 6.0.7
kernel works fine, then on upgrading to Rawhide's 6.2-rc3 it dies with=20

[   41.498694] ena 0000:00:03.0 (unnamed net_device) (uninitialized): Faile=
d to enable MSI-X. irq_cnt -524
[   41.498705] ena 0000:00:03.0: Can not reserve msix vectors
[   41.498712] ena 0000:00:03.0: Failed to enable and set the admin interru=
pts

> > ---
> > Note: This is completely untested, but it compiles so it must be perfec=
t.
>=20
>=20
> I'm working on making it simple for you to test that, by hosting Xen
> HVM guests natively in qemu (under KVM=C2=B9).=C2=A0
>=20
> But I'm absolutely not going to try hacking on both guest and host side
> at the same time when I'm trying to ensure compatibility =E2=80=94 that w=
ay
> lies madness.
>=20
> So for now I'm going to test qemu with older kernels, and maybe someone
> (J=C3=BCrgen}? can test MSI-X to PIRQ support under real Xen?) FWIW if I =
add
> the missing MSI_FLAGS_PCI_MSIX flag then under my qemu I get:
>=20
> =C2=A038:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3180=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 xen-pirq=C2=A0=C2=A0=C2=A0 -msi-x=
=C2=A0=C2=A0=C2=A0=C2=A0 ens4-rx-0
> =C2=A039:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3610=C2=A0 xen-pirq=C2=A0=C2=A0=C2=A0 -msi-x=
=C2=A0=C2=A0=C2=A0=C2=A0 ens4-tx-0
> =C2=A040:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 xen-pirq=C2=A0=C2=
=A0=C2=A0 -msi-x=C2=A0=C2=A0=C2=A0=C2=A0 ens4
>=20
> But without the flags I get:
>=20
> [=C2=A0=C2=A0=C2=A0 8.464212] e1000e 0000:00:04.0 ens4: Failed to initial=
ize MSI interrupts.=C2=A0 Falling back to legacy interrupts.
>=20
> =C2=B9 https://lore.kernel.org/qemu-devel/20230110122042.1562155-1-dwmw2@=
infradead.org/


--=-fjKh0loIuJRGzJfL12nv
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjMwMTE1MjAyNzQ0WjAvBgkqhkiG9w0BCQQxIgQgEVuRC5TT
XSVIGCNaaCP2mTBadklcRarafOUHkixEk+Qwgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgCjarrOzTF2g2zpInRZck17E4WRCOpZU8OR
2z67mhuuqPT3z6VGbDBGfQQNv3SnCMu1fIVcYvBddCr+euhUkv3YbwFL1x5QhmJXdfiePtdBY7vH
9u1dAJ6FobJ5zdPpJpptDkIPB4Psp96T+4t5s3JWQarVWHoFKGItv6aQA5WeDa6+tbaXEPMgwSqR
ycly36VCCUl+wPSOgBZrXA4o+npH5Rvhp2s9qS4itgsx0NKPMXDsPVB8uj9vzV/YPfQr8PIUnE5d
Kauu4H4ttIITfPAMKxpQmiuXw3Y/GCFAx7rXJuwswbxUUAX7ycQMEb/GIUdPQDwe7uggGvuMtvDU
P9XUjizUP2ECBSf7QymND9mtUsxQ0g81DaneF9PhDAFRfPBulihKNSIFrt2c582qqnDM0CFDBAPW
33It4wOZxzoOtU5lysLZqXwcCfJ4nVNW+VfsE8k3xJbozPKmVCqbIMkK6EaLb7S8GYdzyShpH9vj
y7E5z/KqHbA1bOjt1bWcvk4Ll/PMz68DRhT9ncoUguoMPpQZF8fBXjoFI1mOqaMSEXm8Zk6dH49x
jw0e9EkG04dhpd1z1UlC1ecq0L2wSzVsQFpEvRA6KdLlZQL4l6hm0E2EBZWGPPFuoVQNTIktQNuT
L5aNYXCJRWDAN65JTDm/4pjO9xPI/DIOn2JteLI5twAAAAAAAA==


--=-fjKh0loIuJRGzJfL12nv--
