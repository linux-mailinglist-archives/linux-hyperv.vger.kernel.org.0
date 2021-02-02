Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3CC30CD13
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Feb 2021 21:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhBBU2Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Feb 2021 15:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhBBU0j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Feb 2021 15:26:39 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBA6C061573
        for <linux-hyperv@vger.kernel.org>; Tue,  2 Feb 2021 12:25:57 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id u20so6525701qvx.7
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Feb 2021 12:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6vAmtoixgQU0OKZokpeQEbKqPWIYSbKvjSbYlqn+XRQ=;
        b=OdOzhgdSbzYNYQ2N4l8g83MLRbHu+rP9dux8OhhT35oVsdGJlCraNq6zo+IjWHe//X
         N9ZVTfn3aw45GpTIit/x+cq02HY4Xn/hcGat9mwt/DJB4RQ5D/ceuIEkvaJitc7Szd1b
         Fk9kXtfb1S5zeFOWSK9vZ3MXVMSdEsQ3007jHdmOasPb2NPGi6Wqyi4ulHrNOSRBAPnt
         Z29dQARVGVorRfEuK0aPcgRpqsgK/+X7XEAYuLt9dvw7frDiVU4m2u4QnjqQULEj1+/M
         uXmJJ133IHFvy24xCccb9PCyNoNazTpxEBXRvxKWjGLmvQRGpdeJrlqU9Cincl/Kkv42
         EjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6vAmtoixgQU0OKZokpeQEbKqPWIYSbKvjSbYlqn+XRQ=;
        b=M9/7HhL5qVoQu4Ee50pYZfojsiXcqIuht636gJmgo+q7AjLiYkcDUSgDwpeGCn7Err
         yH+H9VxIM9LtIBH5XotVR5snBc6K/C7ZslXkQWlWxcYIoSCOPlOOsAtjognv247vv3lw
         mlY62vU6zoEWmJlEMo0aPUzuhuDl/akU919MK0rwpbGVqRBwMNS8B3UDbdukb2rRfQc7
         /K0VAB41G3tNzoTWEhS2CmzXjWw2HAYYHnygqxyr0UZUj6rqUNvceGuvx/mwW0SpObRt
         h4VmvaBBuY41d71v3ea6lxkMANwwG58rdar8ZzDncV2SJQQJn++Kyvwco1I2awFbdcfm
         UA4w==
X-Gm-Message-State: AOAM531NZm+geEubU7T/jzSbllnvw9iNlyw2+5+H4FdUm7GRhwPo02iO
        LhNMnx3fAIS5B6DBiNJBSqAhENygHULMIcYktpqrhqwX89+HCQ==
X-Google-Smtp-Source: ABdhPJzF8vH0MWTgdtyeenXWKVEt11d0gDsqWw7SijAOu1Hfx0crppzCAY1wiy4hCk1gOlALPK9rNP9tC/ViEjy37Sk=
X-Received: by 2002:a0c:fd8e:: with SMTP id p14mr22361253qvr.37.1612297556199;
 Tue, 02 Feb 2021 12:25:56 -0800 (PST)
MIME-Version: 1.0
From:   Melanie Plageman <melanieplageman@gmail.com>
Date:   Tue, 2 Feb 2021 15:25:43 -0500
Message-ID: <CAAKRu_bfKv0j3BdC-u8A4Eg8poubTsXT64Gkze8snS5fcKtYLA@mail.gmail.com>
Subject: [PATCH v1] scsi: storvsc: Parameterize nr_hw_queues
To:     linux-hyperv@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001cef3005ba604712"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

--0000000000001cef3005ba604712
Content-Type: text/plain; charset="UTF-8"

Proposed patch attached.

While doing some performance tuning of various block device parameters
on Azure to optimize database workloads, we found that reducing the
number of hardware queues (nr_hw_queues used in the block-mq layer and
by storvsc) improved performance of short queue depth writes, like
database journaling.

The Azure premium disks we were testing on often had around 2-3ms
latency for a single small write. Given the IOPS and bandwidth
provisioned on your typical Azure VM paired with an Azure premium disk,
we found that decreasing the LUN queue_depth substantially from the
default (default is 2048) was often required to get reasonable IOPS out
of a small sequential synchronous write with a queue_depth of 1. In our
investigation, the high default queue_depth resulted in such a large
number of outstanding requests against the device that a journaling
write incurred very high latency, slowing overall database performance.

However, even with tuning these defaults (including
/sys/block/sdX/queue/nr_requests), we still incurred high latency,
especially on machines with high core counts, as the number of hardware
queues, nr_hw_queues, is set to be the number of CPUs in storvsc.
nr_hw_queues is, in turn, used to calculate the number of tags available
on the block device, meaning that we still ended up with deeper queues
than intended when requests were submitted to more than one hardware
queue.

We calculated the optimal block device settings, including our intended
queue depth, to utilize as much of provisioned bandwidth as possible
while still getting a reasonable number of IOPS from low queue depth
sequential IO and random IO, but, without parameterizing the number of
hardware queues, we weren't able to fully control this queue_depth.

Attached is a patch which adds a module param to control nr_hw_queues.
The default is the current value (number of CPUs), so it should have no
impact on users who do not set the param.

As a minimal example of the potential benefit, we found that, starting
with a baseline of optimized block device tunings, we could
substantially increase the IOPS of a sequential write job for both a
large Azure premium SSD and a small Azure premium SSD.

On an Azure Standard_F32s_v2 with a single 16 TiB disk, which has a
provisioned max bandwidth of 750 MB/s and provisioned max IOPS of
18000, running Debian 10 with a Linux kernel built from master
(v5.11-rc6 at time of patch testing) with the patch applied, with the
following block device settings:

/sys/block/sdX/device/queue_depth=55

/sys/block/sdX/queue/max_sectors_kb=64,
                    read_ahead_kb=2296,
                    nr_requests=55,
                    wbt_lat_usec=0,
                    scheduler=mq-deadline

And this fio job file:
  [global]
  time_based=1
  ioengine=libaio
  direct=1
  runtime=20

  [job1]
  name=seq_read
  bs=32k
  size=23G
  rw=read
  numjobs=2
  iodepth=110
  iodepth_batch_submit=55
  iodepth_batch_complete=55

  [job2]
  name=seq_write
  bs=8k
  size=10G
  rw=write
  numjobs=1
  iodepth=1
  overwrite=1

With ncpu hardware queues configured, we measured an average of 764 MB/s
read throughput and 153 write IOPS.

With one hardware queue configured, we measured an average of 763 MB/s
read throughput and 270 write IOPS.

And on an Azure Standard_F32s_v2  with a single 16 GiB disk, the
combination having a provisioned max bandwidth of 170 MB/s and a
provisioned max IOPS of 3500, with the following block device settings:

/sys/block/sdX/device/queue_depth=11

/sys/block/sdX/queue/max_sectors_kb=65,
                      read_ahead_kb=520,
                      nr_requests=11,
                      wbt_lat_usec=0,
                      scheduler=mq-deadline

And with this fio job file:
  [global]
  time_based=1
  ioengine=libaio
  direct=1
  runtime=60

  [job1]
  name=seq_read
  bs=32k
  size=5G
  rw=read
  numjobs=2
  iodepth=22
  iodepth_batch_submit=11
  iodepth_batch_complete=11

  [job2]
  name=seq_write
  bs=8k
  size=3G
  rw=write
  numjobs=1
  iodepth=1
  overwrite=1

With ncpu hardware queues configured, we measured an average of 123 MB/s
read throughput and 56 write IOPS.

With one hardware queue configured, we measured an average of 165 MB/s
read throughput and 346 write IOPS.

Providing this option as a module param will help improve performance of
certain workloads on certain devices.

In the attached patch, I check that the value provided for
storvsc_nr_hw_queues is within a valid range at init time and error out
if it is not. I noticed this warning from scripts/checkpatch.pl

  WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
  #64: FILE: drivers/scsi/storvsc_drv.c:2183:
  printk(KERN_ERR "storvsc: Invalid storvsc_nr_hw_queues value of %d.

Should I be using a different function for printing this message?

Regards,
Melanie (Microsoft)

--0000000000001cef3005ba604712
Content-Type: application/octet-stream; 
	name="v1-0001-scsi-storvsc-Parameterize-number-hardware-queues.patch"
Content-Disposition: attachment; 
	filename="v1-0001-scsi-storvsc-Parameterize-number-hardware-queues.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kkogad9x0>
X-Attachment-Id: f_kkogad9x0

RnJvbSAzMjMyYzY5ZDBjYjcwMmM1MzhkODY1NGVkODYwN2NlYzE1YWRmZTAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiTWVsYW5pZSBQbGFnZW1hbiAoTWljcm9zb2Z0KSIgPG1lbGFu
aWVwbGFnZW1hbkBnbWFpbC5jb20+CkRhdGU6IFR1ZSwgMiBGZWIgMjAyMSAxOToxOTozNiArMDAw
MApTdWJqZWN0OiBbUEFUQ0ggdjFdIHNjc2k6IHN0b3J2c2M6IFBhcmFtZXRlcml6ZSBudW1iZXIg
aGFyZHdhcmUgcXVldWVzCgpBZGQgYWJpbGl0eSB0byBzZXQgdGhlIG51bWJlciBvZiBoYXJkd2Fy
ZSBxdWV1ZXMuIFRoZSBkZWZhdWx0IHZhbHVlCnJlbWFpbnMgdGhlIG51bWJlciBvZiBDUFVzLiAg
VGhpcyBmdW5jdGlvbmFsaXR5IGlzIHVzZWZ1bCBpbiBzb21lCmVudmlyb25tZW50cyAoZS5nLiBN
aWNyb3NvZnQgQXp1cmUpIHdoZW4gZGVjcmVhc2luZyB0aGUgbnVtYmVyIG9mCmhhcmR3YXJlIHF1
ZXVlcyBoYXMgYmVlbiBzaG93biB0byBpbXByb3ZlIHBlcmZvcm1hbmNlLgoKU2lnbmVkLW9mZi1i
eTogTWVsYW5pZSBQbGFnZW1hbiAoTWljcm9zb2Z0KSA8bWVsYW5pZXBsYWdlbWFuQGdtYWlsLmNv
bT4KLS0tCiBkcml2ZXJzL3Njc2kvc3RvcnZzY19kcnYuYyB8IDIxICsrKysrKysrKysrKysrKysr
KystLQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMgYi9kcml2ZXJzL3Njc2kvc3Rv
cnZzY19kcnYuYwppbmRleCAyZTRmYTc3NDQ1ZmQuLmQ3MmFiNmRhZjlhZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMKKysrIGIvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2
LmMKQEAgLTM3OCwxMCArMzc4LDE0IEBAIHN0YXRpYyB1MzIgbWF4X291dHN0YW5kaW5nX3JlcV9w
ZXJfY2hhbm5lbDsKIHN0YXRpYyBpbnQgc3RvcnZzY19jaGFuZ2VfcXVldWVfZGVwdGgoc3RydWN0
IHNjc2lfZGV2aWNlICpzZGV2LCBpbnQgcXVldWVfZGVwdGgpOwogCiBzdGF0aWMgaW50IHN0b3J2
c2NfdmNwdXNfcGVyX3N1Yl9jaGFubmVsID0gNDsKK3N0YXRpYyBpbnQgc3RvcnZzY19ucl9od19x
dWV1ZXMgPSAtMTsKIAogbW9kdWxlX3BhcmFtKHN0b3J2c2NfcmluZ2J1ZmZlcl9zaXplLCBpbnQs
IFNfSVJVR08pOwogTU9EVUxFX1BBUk1fREVTQyhzdG9ydnNjX3JpbmdidWZmZXJfc2l6ZSwgIlJp
bmcgYnVmZmVyIHNpemUgKGJ5dGVzKSIpOwogCittb2R1bGVfcGFyYW0oc3RvcnZzY19ucl9od19x
dWV1ZXMsIGludCwgU19JUlVHTyk7CitNT0RVTEVfUEFSTV9ERVNDKHN0b3J2c2NfbnJfaHdfcXVl
dWVzLCAiTnVtYmVyIG9mIGhhcmR3YXJlIHF1ZXVlcyIpOworCiBtb2R1bGVfcGFyYW0oc3RvcnZz
Y192Y3B1c19wZXJfc3ViX2NoYW5uZWwsIGludCwgU19JUlVHTyk7CiBNT0RVTEVfUEFSTV9ERVND
KHN0b3J2c2NfdmNwdXNfcGVyX3N1Yl9jaGFubmVsLCAiUmF0aW8gb2YgVkNQVXMgdG8gc3ViY2hh
bm5lbHMiKTsKIApAQCAtMjAwNCw4ICsyMDA4LDEyIEBAIHN0YXRpYyBpbnQgc3RvcnZzY19wcm9i
ZShzdHJ1Y3QgaHZfZGV2aWNlICpkZXZpY2UsCiAJICogRm9yIG5vbi1JREUgZGlza3MsIHRoZSBo
b3N0IHN1cHBvcnRzIG11bHRpcGxlIGNoYW5uZWxzLgogCSAqIFNldCB0aGUgbnVtYmVyIG9mIEhX
IHF1ZXVlcyB3ZSBhcmUgc3VwcG9ydGluZy4KIAkgKi8KLQlpZiAoIWRldl9pc19pZGUpCi0JCWhv
c3QtPm5yX2h3X3F1ZXVlcyA9IG51bV9wcmVzZW50X2NwdXMoKTsKKwlpZiAoIWRldl9pc19pZGUp
IHsKKwkJaWYgKHN0b3J2c2NfbnJfaHdfcXVldWVzID09IC0xKQorCQkJaG9zdC0+bnJfaHdfcXVl
dWVzID0gbnVtX3ByZXNlbnRfY3B1cygpOworCQllbHNlCisJCQlob3N0LT5ucl9od19xdWV1ZXMg
PSBzdG9ydnNjX25yX2h3X3F1ZXVlczsKKwl9CiAKIAkvKgogCSAqIFNldCB0aGUgZXJyb3IgaGFu
ZGxlciB3b3JrIHF1ZXVlLgpAQCAtMjE1NSw2ICsyMTYzLDcgQEAgc3RhdGljIHN0cnVjdCBmY19m
dW5jdGlvbl90ZW1wbGF0ZSBmY190cmFuc3BvcnRfZnVuY3Rpb25zID0gewogc3RhdGljIGludCBf
X2luaXQgc3RvcnZzY19kcnZfaW5pdCh2b2lkKQogewogCWludCByZXQ7CisJaW50IG5jcHVzID0g
bnVtX3ByZXNlbnRfY3B1cygpOwogCiAJLyoKIAkgKiBEaXZpZGUgdGhlIHJpbmcgYnVmZmVyIGRh
dGEgc2l6ZSAod2hpY2ggaXMgMSBwYWdlIGxlc3MKQEAgLTIxNjksNiArMjE3OCwxNCBAQCBzdGF0
aWMgaW50IF9faW5pdCBzdG9ydnNjX2Rydl9pbml0KHZvaWQpCiAJCXZtc2NzaV9zaXplX2RlbHRh
LAogCQlzaXplb2YodTY0KSkpOwogCisJaWYgKHN0b3J2c2NfbnJfaHdfcXVldWVzID4gbmNwdXMg
fHwgc3RvcnZzY19ucl9od19xdWV1ZXMgPT0gMCB8fAorCQkJc3RvcnZzY19ucl9od19xdWV1ZXMg
PCAtMSkgeworCQlwcmludGsoS0VSTl9FUlIgInN0b3J2c2M6IEludmFsaWQgc3RvcnZzY19ucl9o
d19xdWV1ZXMgdmFsdWUgb2YgJWQuCisJCQkJCQlWYWxpZCB2YWx1ZXMgaW5jbHVkZSAtMSBhbmQg
MS0lZC5cbiIsCisJCQkJc3RvcnZzY19ucl9od19xdWV1ZXMsIG5jcHVzKTsKKwkJcmV0dXJuIC1F
SU5WQUw7CisJfQorCiAjaWYgSVNfRU5BQkxFRChDT05GSUdfU0NTSV9GQ19BVFRSUykKIAlmY190
cmFuc3BvcnRfdGVtcGxhdGUgPSBmY19hdHRhY2hfdHJhbnNwb3J0KCZmY190cmFuc3BvcnRfZnVu
Y3Rpb25zKTsKIAlpZiAoIWZjX3RyYW5zcG9ydF90ZW1wbGF0ZSkKLS0gCjIuMjAuMQoK
--0000000000001cef3005ba604712--
