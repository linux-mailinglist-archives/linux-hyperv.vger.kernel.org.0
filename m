Return-Path: <linux-hyperv+bounces-10821-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDV7MMALBGoWCwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10821-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 07:27:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C9952D872
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 07:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DD123007F49
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 05:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2481E3A48FA;
	Wed, 13 May 2026 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLf5BIL4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006AD3A48F0;
	Wed, 13 May 2026 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778650046; cv=none; b=OehIx2ax9nyEW2U7eUZ/kFNleuNxRmpf1CV79b7rI/Am57LF2jkWKrzrj+I6hr4ZqEhp2tn7nII/BS1qDM6yHQ5Ul8J4AO0l5+2rtVZvRmtmhr81hwBJ6ypO9kP7AotBopIi134lZxsAB/Ii9pSX7ekj6IzEAr52gbdh1qJ8PAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778650046; c=relaxed/simple;
	bh=nsQC6XHxgt+JZ289WhMQPu99KpURpXRNwI2mFuZv1ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cFgWKmxPAnVAK5vgYf+FqMtyVi2BDne9bGY0wGLNVEEHsWyBLaiw6H7JhB7Z1r3pTcbOlhVaa9TsaiBcqJQXqoLSSepgSqqo+cZ8FnfApiWXWh8J88EtWxGJFSQEHCrPKNRETWIPJhSmf1XexuD6sHFR65n+0M8wBA8xbIy1po0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLf5BIL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803A7C2BCB7;
	Wed, 13 May 2026 05:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778650045;
	bh=nsQC6XHxgt+JZ289WhMQPu99KpURpXRNwI2mFuZv1ac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QLf5BIL4CMDugTdsQlQJHeIZsUZtZNteJ9lhyFrq+RQnNjil8fxgVJ2bO6fMHFfZd
	 ki66yYXTz1JMJG8DR2wUrulyP1hMgxb5JTOBQtioG6GrlBti3PyVOMcztrWwp+57nb
	 0qgt4mUkGFFSV777oN7t2zOhHmvByWHfKyXw9zRCz7TJrxIKXXCUt1Dj5q3YKFQC2H
	 v0lwFTVUbRVQNT11l8AXAVUAp4X8rKZmNQ+fVX7aw9uv98f2WeAHqEOf8Lb8uMCeMo
	 C4FEYyvoBqu2G/sfLvbMXOGgy/0GPY34xU/Vf33NuMjKWPopN5rrvQYdPjr/IvH/4Z
	 SDrWv80NkCQPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 06/11] mshv: Add ioctl support for MSHV-VFIO bridge
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260512020259.1678627-7-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-7-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:27:24 +0000
Message-Id: <20260513052725.803A7C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 27C9952D872
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10821-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] FD leak and potential deadlock on copy_to_user() failure after ano=
n_inode_getfd().
- [Medium] Asymmetric memory lifecycle and inconsistent device_release hand=
ling.
- [Medium] Missing validation of unknown flags in mshv_partition_ioctl_crea=
te_device().
--

commit a0a0db24ca9d194302f458a7afa8a424cc357990
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Add ioctl support for MSHV-VFIO bridge device

This commit adds an ioctl for creating MSHV devices for a partition.
Currently only VFIO device types are supported, doing setup for the bridge
code in mshv_vfio.c.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 02c107458be90..6ceb5f608589f 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c

[ ... ]

> @@ -1625,6 +1625,119 @@ mshv_partition_ioctl_initialize(struct mshv_parti=
tion *partition)

[ ... ]

> +static int mshv_device_fop_release(struct inode *inode, struct file *fil=
p)
> +{
> +	struct mshv_device *mshv_dev =3D filp->private_data;
> +	struct mshv_partition *partition =3D mshv_dev->device_pt;
> +
> +	if (mshv_dev->device_ops->device_release) {
> +		mutex_lock(&partition->pt_mutex);
> +		hlist_del(&mshv_dev->device_ptnode);
> +		mshv_dev->device_ops->device_release(mshv_dev);
> +		mutex_unlock(&partition->pt_mutex);
> +	}

What happens if a future device type does not implement the device_release
callback? It looks like the device would remain indefinitely linked in=20
partition->pt_devices while the file descriptor is closed, leading to
list corruption and a memory leak.

Since the device structure is allocated by the core module via kzalloc(),
would it be safer to handle the list removal and generic kfree()
unconditionally in this function?

> +
> +	mshv_partition_put(partition);
> +	return 0;
> +}
> +
> +static const struct file_operations mshv_device_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.unlocked_ioctl =3D mshv_device_fop_ioctl,
> +	.release =3D mshv_device_fop_release,
> +};
> +
> +static long mshv_partition_ioctl_create_device(struct mshv_partition *pa=
rtition,
> +					       void __user *uarg)
> +{
> +	long rc;
> +	struct mshv_create_device devargk;
> +	struct mshv_device *mshv_dev;
> +	const struct mshv_device_ops *vfio_ops;
> +
> +	if (copy_from_user(&devargk, uarg, sizeof(devargk)))
> +		return -EFAULT;
> +
> +	/* At present, only VFIO is supported */
> +	if (devargk.type !=3D MSHV_DEV_TYPE_VFIO)
> +		return -ENODEV;
> +
> +	if (devargk.flags & MSHV_CREATE_DEVICE_TEST)
> +		return 0;

Should we explicitly validate that no undefined flags are set here?=20
If a future kernel version introduces new flags for device creation, older=
=20
kernels will silently ignore them and return success instead of -EINVAL,=20
breaking forward compatibility.

> +
> +	/* This is freed later by mshv_vfio_release_device() */
> +	mshv_dev =3D kzalloc(sizeof(*mshv_dev), GFP_KERNEL_ACCOUNT);
> +	if (mshv_dev =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	vfio_ops =3D &mshv_vfio_device_ops;
> +	mshv_dev->device_ops =3D vfio_ops;
> +	mshv_dev->device_pt =3D partition;
> +
> +	rc =3D vfio_ops->device_create(mshv_dev);
> +	if (rc < 0) {
> +		kfree(mshv_dev);
> +		return rc;
> +	}
> +
> +	hlist_add_head(&mshv_dev->device_ptnode, &partition->pt_devices);
> +
> +	mshv_partition_get(partition);
> +	rc =3D anon_inode_getfd(vfio_ops->device_name, &mshv_device_fops,
> +			      mshv_dev, O_RDWR | O_CLOEXEC);
> +	if (rc < 0)
> +		goto undo_out;
> +
> +	devargk.fd =3D rc;
> +	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
> +		return -EFAULT;    /* cleanup in mshv_device_fop_release() */

Does this sequence leak the file descriptor if copy_to_user() fails?

The anon_inode_getfd() call installs the file descriptor into the process's=
=20
fd table. If the subsequent copy_to_user() fails, the function returns=20
-EFAULT, but the user space application never receives the fd number to=20
explicitly close it, resulting in a leaked file descriptor.

Additionally, can this trigger a deadlock?

The ioctl is called with partition->pt_mutex held. If a malicious user=20
provides a buffer backed by userfaultfd, the copy_to_user() call will=20
block, holding the mutex. Concurrently, another thread could find the=20
new fd in /proc/self/fd and call close(), which invokes=20
mshv_device_fop_release(). That release function unconditionally attempts=20
to acquire partition->pt_mutex, resulting in a deadlock.

Would it be better to separate file allocation and installation by using=20
get_unused_fd_flags(), anon_inode_getfile(), and only calling fd_install()=
=20
after copy_to_user() succeeds?

> +
> +	return 0;
> +
> +undo_out:
> +	hlist_del(&mshv_dev->device_ptnode);
> +	vfio_ops->device_release(mshv_dev);    /* will kfree(mshv_dev) */

If a future device type does not implement the device_release callback,
could this result in a NULL pointer dereference?

> +	mshv_partition_put(partition);
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512020259.1678=
627-1-mrathor@linux.microsoft.com?part=3D6

